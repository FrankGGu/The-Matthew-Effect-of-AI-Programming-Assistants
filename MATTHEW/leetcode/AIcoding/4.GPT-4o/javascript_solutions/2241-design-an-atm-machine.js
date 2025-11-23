class ATM {
    constructor() {
        this.bills = [20, 50, 100, 200, 500];
        this.counts = new Array(5).fill(0);
    }

    deposit(bills) {
        for (let i = 0; i < 5; i++) {
            this.counts[i] += bills[i];
        }
    }

    withdraw(amount) {
        const withdrawCounts = new Array(5).fill(0);
        for (let i = 4; i >= 0; i--) {
            while (amount >= this.bills[i] && this.counts[i] > 0) {
                amount -= this.bills[i];
                withdrawCounts[i]++;
                this.counts[i]--;
            }
        }
        if (amount > 0) {
            for (let i = 0; i < 5; i++) {
                this.counts[i] += withdrawCounts[i];
            }
            return [-1];
        }
        return withdrawCounts;
    }
}