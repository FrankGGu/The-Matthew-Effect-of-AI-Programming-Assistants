class Accumulator {
    constructor(init) {
        this.value = init;
    }

    add(val) {
        this.value += val;
    }

    subtract(val) {
        this.value -= val;
    }

    getValue() {
        return this.value;
    }
}