class ZeroEvenOdd {
    constructor(n) {
        this.n = n;
        this.current = 1;
        this.zeroTurn = true;
        this.lock = new Promise(resolve => resolve());
    }

    async zero(printNumber) {
        for (let i = 0; i < this.n; i++) {
            await this.lock;
            if (!this.zeroTurn) continue;
            printNumber(0);
            this.zeroTurn = false;
            this.lock = new Promise(resolve => {
                this.resolve = resolove;
            });
            this.resolve();
        }
    }

    async even(printNumber) {
        while (this.current <= this.n) {
            await this.lock;
            if (this.zeroTurn || this.current % 2 !== 0) continue;
            printNumber(this.current);
            this.current++;
            this.zeroTurn = true;
            this.lock = new Promise(resolve => {
                this.resolve = resolve;
            });
            this.resolve();
        }
    }

    async odd(printNumber) {
        while (this.current <= this.n) {
            await this.lock;
            if (this.zeroTurn || this.current % 2 === 0) continue;
            printNumber(this.current);
            this.current++;
            this.zeroTurn = true;
            this.lock = new Promise(resolve => {
                this.resolve = resolve;
            });
            this.resolve();
        }
    }
}