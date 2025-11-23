var Bank = function(balance) {
    this.balances = balance;
    this.n = balance.length;
};

Bank.prototype.isValidAccount = function(accountNum) {
    return accountNum >= 1 && accountNum <= this.n;
};

Bank.prototype.transfer = function(account1, account2, amount) {
    if (!this.isValidAccount(account1) || !this.isValidAccount(account2)) {
        return false;
    }
    if (this.balances[account1 - 1] < amount) {
        return false;
    }
    this.balances[account1 - 1] -= amount;
    this.balances[account2 - 1] += amount;
    return true;
};

Bank.prototype.deposit = function(account, amount) {
    if (!this.isValidAccount(account)) {
        return false;
    }
    this.balances[account - 1] += amount;
    return true;
};

Bank.prototype.withdraw = function(account, amount) {
    if (!this.isValidAccount(account)) {
        return false;
    }
    if (this.balances[account - 1] < amount) {
        return false;
    }
    this.balances[account - 1] -= amount;
    return true;
};