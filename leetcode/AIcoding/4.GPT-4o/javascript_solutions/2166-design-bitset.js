class Bitset {
    constructor(size) {
        this.size = size;
        this.bits = new Array(size).fill(0);
        this.flipped = false;
        this.count = 0;
    }

    fix(idx) {
        if (this.flipped) {
            if (this.bits[idx] === 0) {
                this.bits[idx] = 1;
                this.count--;
            }
        } else {
            if (this.bits[idx] === 1) {
                this.bits[idx] = 0;
                this.count++;
            }
        }
    }

    unfix(idx) {
        if (this.flipped) {
            if (this.bits[idx] === 1) {
                this.bits[idx] = 0;
                this.count--;
            }
        } else {
            if (this.bits[idx] === 0) {
                this.bits[idx] = 1;
                this.count++;
            }
        }
    }

    flip() {
        this.flipped = !this.flipped;
        this.count = this.size - this.count;
    }

    all() {
        return this.count === this.size;
    }

    one() {
        return this.count > 0;
    }

    count() {
        return this.count;
    }

    toString() {
        return this.bits.map(bit => this.flipped ? 1 - bit : bit).join('');
    }
}