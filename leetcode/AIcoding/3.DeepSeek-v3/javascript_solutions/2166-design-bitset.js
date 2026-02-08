class Bitset {
    constructor(size) {
        this.size = size;
        this.bits = new Array(size).fill(0);
        this.flipped = false;
        this.countOnes = 0;
    }

    fix(idx) {
        if (this.flipped) {
            if (this.bits[idx] === 1) {
                this.bits[idx] = 0;
                this.countOnes++;
            }
        } else {
            if (this.bits[idx] === 0) {
                this.bits[idx] = 1;
                this.countOnes++;
            }
        }
    }

    unfix(idx) {
        if (this.flipped) {
            if (this.bits[idx] === 0) {
                this.bits[idx] = 1;
                this.countOnes--;
            }
        } else {
            if (this.bits[idx] === 1) {
                this.bits[idx] = 0;
                this.countOnes--;
            }
        }
    }

    flip() {
        this.flipped = !this.flipped;
        this.countOnes = this.size - this.countOnes;
    }

    all() {
        return this.countOnes === this.size;
    }

    one() {
        return this.countOnes > 0;
    }

    count() {
        return this.countOnes;
    }

    toString() {
        let res = [];
        for (let i = 0; i < this.size; i++) {
            if (this.flipped) {
                res.push(this.bits[i] === 0 ? '1' : '0');
            } else {
                res.push(this.bits[i] === 1 ? '1' : '0');
            }
        }
        return res.join('');
    }
}