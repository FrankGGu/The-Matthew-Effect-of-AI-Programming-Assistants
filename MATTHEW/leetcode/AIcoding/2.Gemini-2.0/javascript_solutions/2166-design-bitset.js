class Bitset {
    constructor(size) {
        this.size = size;
        this.bits = new Array(size).fill(0);
        this.flipped = 0;
    }

    fix(idx) {
        if (this.bits[idx] === 0) {
            this.bits[idx] = 1;
            if (this.flipped > 0) {
                this.flipped--;
            }
        }
    }

    unfix(idx) {
        if (this.bits[idx] === 1) {
            this.bits[idx] = 0;
            this.flipped++;
        }
    }

    flip() {
        this.flipped = this.size - this.flipped;
        for (let i = 0; i < this.size; i++) {
            this.bits[i] = 1 - this.bits[i];
        }
    }

    all() {
        return this.flipped === 0;
    }

    one() {
        return this.size - this.flipped > 0;
    }

    count() {
        return this.size - this.flipped;
    }

    toString() {
        let result = "";
        for (let i = 0; i < this.size; i++) {
            result += this.bits[i];
        }
        return result;
    }
}