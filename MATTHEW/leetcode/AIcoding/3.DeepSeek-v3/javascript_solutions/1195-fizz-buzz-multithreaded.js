class FizzBuzz {
    constructor(n) {
        this.n = n;
        this.current = 1;
        this.lock = new Promise(resolve => resolve());
    }

    async fizz(printFizz) {
        while (this.current <= this.n) {
            await this.lock;
            if (this.current > this.n) break;
            if (this.current % 3 === 0 && this.current % 5 !== 0) {
                printFizz();
                this.current++;
                this.lock = new Promise(resolve => resolve());
            }
        }
    }

    async buzz(printBuzz) {
        while (this.current <= this.n) {
            await this.lock;
            if (this.current > this.n) break;
            if (this.current % 5 === 0 && this.current % 3 !== 0) {
                printBuzz();
                this.current++;
                this.lock = new Promise(resolve => resolve());
            }
        }
    }

    async fizzbuzz(printFizzBuzz) {
        while (this.current <= this.n) {
            await this.lock;
            if (this.current > this.n) break;
            if (this.current % 15 === 0) {
                printFizzBuzz();
                this.current++;
                this.lock = new Promise(resolve => resolve());
            }
        }
    }

    async number(printNumber) {
        while (this.current <= this.n) {
            await this.lock;
            if (this.current > this.n) break;
            if (this.current % 3 !== 0 && this.current % 5 !== 0) {
                printNumber(this.current);
                this.current++;
                this.lock = new Promise(resolve => resolve());
            }
        }
    }
}