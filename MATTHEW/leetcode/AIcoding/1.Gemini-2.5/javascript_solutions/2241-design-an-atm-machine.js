class ATM {
    constructor() {
        this.banknotes = [0, 0, 0, 0, 0]; // Counts for [20, 50, 100, 200, 500]
        this.denominations = [20, 50, 100, 200, 500];
    }

    deposit(banknotesCount) {
        for (let i = 0; i < 5; i++) {
            this.banknotes[i] += banknotesCount[i];
        }
    }

    withdraw(amount) {
        const withdrawnBanknotes = [0, 0, 0, 0, 0];
        const tempBanknotes = [...this.banknotes]; // Use a temporary copy for trial withdrawal

        for (let i = 4; i >= 0; i--) { // Iterate from largest denomination to smallest
            const denomination = this.denominations[i];
            if (amount >= denomination) {
                const numNotesToTake = Math.min(Math.floor(amount / denomination), tempBanknotes[i]);
                withdrawnBanknotes[i] = numNotesToTake;
                amount -= numNotesToTake * denomination;
                tempBanknotes[i] -= numNotesToTake;
            }
        }

        if (amount === 0) {
            this.banknotes = tempBanknotes; // Update ATM's actual banknotes
            return withdrawnBanknotes;
        } else {
            return [-1]; // Cannot withdraw the exact amount
        }
    }
}