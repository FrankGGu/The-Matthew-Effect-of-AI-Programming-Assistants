var ATM = function() {
    this.balance = [0, 0, 0, 0, 0];
    this.denominations = [20, 50, 100, 200, 500];
};

ATM.prototype.reset = function() {
    this.balance = [0, 0, 0, 0, 0];
};

ATM.prototype.getBalance = function() {
    return this.balance;
};

ATM.prototype.withdraw = function(amount) {
    const temp = [...this.balance];
    const result = [0, 0, 0, 0, 0];

    for (let i = 4; i >= 0; i--) {
        if (amount >= this.denominations[i]) {
            const count = Math.floor(amount / this.denominations[i]);
            const take = Math.min(count, temp[i]);
            result[i] = take;
            amount -= take * this.denominations[i];
            temp[i] -= take;
        }
    }

    if (amount === 0) {
        this.balance = temp;
        return result;
    } else {
        return [-1];
    }
};