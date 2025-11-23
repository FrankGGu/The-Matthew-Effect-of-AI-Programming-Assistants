class RandomizedCollection {
    constructor() {
        this.values = [];
        this.indices = new Map();
    }

    insert(val) {
        this.values.push(val);
        if (!this.indices.has(val)) {
            this.indices.set(val, new Set());
        }
        this.indices.get(val).add(this.values.length - 1);
        return this.indices.get(val).size === 1;
    }

    remove(val) {
        if (!this.indices.has(val) || this.indices.get(val).size === 0) {
            return false;
        }

        const indexToRemove = this.indices.get(val).values().next().value;
        this.indices.get(val).delete(indexToRemove);

        if (indexToRemove !== this.values.length - 1) {
            const lastVal = this.values[this.values.length - 1];
            this.values[indexToRemove] = lastVal;
            this.indices.get(lastVal).delete(this.values.length - 1);
            this.indices.get(lastVal).add(indexToRemove);
        }

        this.values.pop();

        return true;
    }

    getRandom() {
        return this.values[Math.floor(Math.random() * this.values.length)];
    }
}