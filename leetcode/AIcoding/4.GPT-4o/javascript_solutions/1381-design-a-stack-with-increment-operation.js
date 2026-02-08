class CustomStack {
    constructor(maxSize) {
        this.maxSize = maxSize;
        this.stack = [];
        this.incrementArray = [];
    }

    push(x) {
        if (this.stack.length < this.maxSize) {
            this.stack.push(x);
            this.incrementArray.push(0);
        }
    }

    pop() {
        if (this.stack.length === 0) return -1;
        const index = this.stack.length - 1;
        const increment = this.incrementArray[index];
        this.incrementArray.pop();
        const value = this.stack.pop() + increment;
        if (this.stack.length > 0) {
            this.incrementArray[index - 1] += increment;
        }
        return value;
    }

    increment(k, val) {
        const index = Math.min(k, this.stack.length) - 1;
        if (index >= 0) {
            this.incrementArray[index] += val;
        }
    }
}