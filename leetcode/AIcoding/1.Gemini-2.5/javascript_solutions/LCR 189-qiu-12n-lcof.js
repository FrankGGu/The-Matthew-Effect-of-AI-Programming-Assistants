class Accumulator {
    constructor() {
        this.sum = 0;
    }

    add(number) {
        this.sum += number;
        return this.sum;
    }
}