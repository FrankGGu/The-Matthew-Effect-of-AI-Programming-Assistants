class ATM {
    constructor() {
        this.notes = [20, 50, 100, 200, 500];
        this.counts = [0, 0, 0, 0, 0];
    }

    deposit(banknotesCount) {
        for (let i = 0; i < banknotesCount.length; i++) {
            this.counts[i] += banknotesCount[i];
        }
    }

    withdraw(amount) {
        const res = [0, 0, 0, 0, 0];
        let remaining = amount;
        for (let i = this.notes.length - 1; i >= 0; i--) {
            const note = this.notes[i];
            const take = Math.min(Math.floor(remaining / note), this.counts[i]);
            res[i] = take;
            remaining -= take * note;
        }
        if (remaining !== 0) {
            return [-1];
        }
        for (let i = 0; i < res.length; i++) {
            this.counts[i] -= res[i];
        }
        return res;
    }
}