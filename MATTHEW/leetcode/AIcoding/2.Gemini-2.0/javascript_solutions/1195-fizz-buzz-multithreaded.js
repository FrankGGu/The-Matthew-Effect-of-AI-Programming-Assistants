class FizzBuzz {
    constructor(n) {
        this.n = n;
        this.i = 1;
    }

    fizz(callback) {
        while (this.i <= this.n) {
            if (this.i % 3 === 0 && this.i % 5 !== 0) {
                callback();
                this.i++;
            } else {
                Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0);
            }
        }
    }

    buzz(callback) {
        while (this.i <= this.n) {
            if (this.i % 3 !== 0 && this.i % 5 === 0) {
                callback();
                this.i++;
            } else {
                Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0);
            }
        }
    }

    fizzbuzz(callback) {
        while (this.i <= this.n) {
            if (this.i % 3 === 0 && this.i % 5 === 0) {
                callback();
                this.i++;
            } else {
                Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0);
            }
        }
    }

    number(callback) {
        while (this.i <= this.n) {
            if (this.i % 3 !== 0 && this.i % 5 !== 0) {
                callback(this.i);
                this.i++;
            } else {
                Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0);
            }
        }
    }
}