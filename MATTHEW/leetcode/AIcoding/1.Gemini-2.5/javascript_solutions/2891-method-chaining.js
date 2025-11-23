class Calculator {
    constructor(initialValue = 0) {
        this.value = initialValue;
    }

    add(num) {
        this.value += num;
        return this;
    }

    subtract(num) {
        this.value -= num;
        return this;
    }

    multiply(num) {
        this.value *= num;
        return this;
    }

    divide(num) {
        if (num === 0) {
            throw new Error("Cannot divide by zero");
        }
        this.value /= num;
        return this;
    }

    getResult() {
        return this.value;
    }
}