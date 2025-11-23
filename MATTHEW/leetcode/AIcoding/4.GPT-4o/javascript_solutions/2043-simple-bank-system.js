class Bank {
    constructor(balance) {
        this.accounts = balance;
    }

    transfer(sender, receiver, amount) {
        if (sender > this.accounts.length || receiver > this.accounts.length || this.accounts[sender - 1] < amount) {
            return false;
        }
        this.accounts[sender - 1] -= amount;
        this.accounts[receiver - 1] += amount;
        return true;
    }

    deposit(account, amount) {
        if (account > this.accounts.length) {
            return false;
        }
        this.accounts[account - 1] += amount;
        return true;
    }

    withdraw(account, amount) {
        if (account > this.accounts.length || this.accounts[account - 1] < amount) {
            return false;
        }
        this.accounts[account - 1] -= amount;
        return true;
    }
}