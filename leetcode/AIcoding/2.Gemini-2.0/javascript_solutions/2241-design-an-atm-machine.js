class ATM {
    constructor() {
        this.banknotes = [0, 0, 0, 0, 0]; // [20, 50, 100, 200, 500]
        this.values = [20, 50, 100, 200, 500];
    }

    deposit(banknotesCount) {
        for (let i = 0; i < 5; i++) {
            this.banknotes[i] += banknotesCount[i];
        }
    }

    withdraw(amount) {
        const withdrawn = [0, 0, 0, 0, 0];
        for (let i = 4; i >= 0; i--) {
            const count = Math.min(Math.floor(amount / this.values[i]), this.banknotes[i]);
            withdrawn[i] = count;
            amount -= count * this.values[i];
        }

        if (amount !== 0) {
            return [-1];
        }

        for (let i = 0; i < 5; i++) {
            this.banknotes[i] -= withdrawn[i];
        }

        return withdrawn;
    }
}