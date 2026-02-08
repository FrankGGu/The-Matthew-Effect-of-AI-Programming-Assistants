class ZeroEvenOdd {
    constructor(n) {
        this.n = n;
        this.zeroQueue = [];
        this.evenQueue = [];
        this.oddQueue = [];
        this.lock = new Array(3).fill(0);
    }

    printNumber(num) {
        process.stdout.write(num.toString());
    }

    zero(printNumber) {
        for (let i = 0; i < this.n; i++) {
            this.lock[0] = 1;
            printNumber(0);
            if (i % 2 === 0) {
                this.lock[1] = 1;
                this.evenQueue.push(i + 1);
            } else {
                this.lock[2] = 1;
                this.oddQueue.push(i + 1);
            }
            while (this.lock[1] === 0 && this.lock[2] === 0);
        }
    }

    even(printNumber) {
        for (let i = 2; i <= this.n; i += 2) {
            while (this.lock[1] === 0);
            printNumber(i);
            this.lock[1] = 0;
            this.lock[0] = 0;
        }
    }

    odd(printNumber) {
        for (let i = 1; i <= this.n; i += 2) {
            while (this.lock[2] === 0);
            printNumber(i);
            this.lock[2] = 0;
            this.lock[0] = 0;
        }
    }
}

const zeroEvenOdd = new ZeroEvenOdd(n);
const printNumber = (num) => { };

const zeroThread = new Thread(() => zeroEvenOdd.zero(printNumber));
const evenThread = new Thread(() => zeroEvenOdd.even(printNumber));
const oddThread = new Thread(() => zeroEvenOdd.odd(printNumber));

zeroThread.start();
evenThread.start();
oddThread.start();