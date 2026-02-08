class RLEIterator {
    constructor(encoding) {
        this.encoding = encoding;
        this.index = 0;
        this.count = 0;
    }

    next(n) {
        let res = -1;
        while (n > 0 && this.index < this.encoding.length) {
            if (this.count === 0) {
                this.count = this.encoding[this.index];
                this.index++;
                res = this.encoding[this.index];
                this.index++;
            }

            if (n >= this.count) {
                n -= this.count;
                this.count = 0;
            } else {
                this.count -= n;
                n = 0;
            }
        }

        return n === 0 ? res : -1;
    }
}