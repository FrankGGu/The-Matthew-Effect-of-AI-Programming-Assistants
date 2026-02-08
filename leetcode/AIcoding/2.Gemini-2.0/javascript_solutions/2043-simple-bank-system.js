var Bank = function(balance) {
    this.balance = balance;
};

Bank.prototype.transfer = function(account1, account2, money) {
    if (account1 < 1 || account1 > this.balance.length || account2 < 1 || account2 > this.balance.length) {
        return false;
    }
    if (this.balance[account1 - 1] < money) {
        return false;
    }
    this.balance[account1 - 1] -= money;
    this.balance[account2 - 1] += money;
    return true;
};

Bank.prototype.deposit = function(account, money) {
    if (account < 1 || account > this.balance.length) {
        return false;
    }
    this.balance[account - 1] += money;
    return true;
};

Bank.prototype.withdraw = function(account, money) {
    if (account < 1 || account > this.balance.length) {
        return false;
    }
    if (this.balance[account - 1] < money) {
        return false;
    }
    this.balance[account - 1] -= money;
    return true;
};