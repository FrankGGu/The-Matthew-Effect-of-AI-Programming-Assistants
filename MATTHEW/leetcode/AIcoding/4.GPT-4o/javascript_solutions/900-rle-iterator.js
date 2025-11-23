class RLEIterator {
    constructor(A) {
        this.A = A;
        this.index = 0;
        this.count = 0;
    }

    next(n) {
        while (this.index < this.A.length) {
            if (this.count + n <= this.A[this.index]) {
                this.count += n;
                return this.A[this.index + 1];
            }
            n -= this.A[this.index] - this.count;
            this.index += 2;
            this.count = 0;
        }
        return -1;
    }
}