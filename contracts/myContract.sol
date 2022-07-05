//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MopedShop {
    
    bool fullPaid = false;
    mapping (address => bool) customers; // mapping - dict, not public
    
    uint256 public price = 2 ether; // unsigned integer 
    address public owner;
    address public shopAddress;

    event Sold(uint _price, address _shopAddress);

    constructor(){
        owner = msg.sender; // msg - global variable    
        shopAddress = address(this);
    }

    function getCustomer(address customer) public view returns(bool){
        require(owner == msg.sender, "You are not the owner of contract!"); // only contract owner can add customers 

        return customers[customer];
    }

    function addCustomer(address customer) public {
        require(owner == msg.sender, "You are not the owner of contract!"); // only contract owner can add customers 
        customers[customers] = true;
    }

    function getBalance() public view returns(uint) {
        return shopAddress.balance; // .balance - solidity tool 
    }
 
    function withdrawAll() public {
        require(owner == msg.sender && fullPaid && shopAddress.balance > 0, "Rejected!");

        address payable receiver = payable(msg.sender);

        receiver.transfer(shopAddress.balance); // send whole balance
    }

    receive() external payable{
        require(customers[msg.sender] && msg.value <= price && !fullPaid, "Rejected!");

        if (shopAddress.balance == price) {
            fullPaid = true;

            emit Sold(price, shopAddress);
        }

    }
}