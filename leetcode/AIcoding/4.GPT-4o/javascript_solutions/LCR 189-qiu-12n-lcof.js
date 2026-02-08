class Accumulator {
    constructor() {
        this.sum = 0;
    }

    add(x) {
        this.sum += x;
        return this.sum;
    }
}