class RandomizedCollection {
    constructor() {
        this.map = new Map();
        this.list = [];
    }

    insert(val) {
        if (!this.map.has(val)) {
            this.map.set(val, new Set());
        }
        this.map.get(val).add(this.list.length);
        this.list.push(val);
        return this.map.get(val).size === 1;
    }

    remove(val) {
        if (!this.map.has(val) || this.map.get(val).size === 0) {
            return false;
        }
        const indexToRemove = this.map.get(val).values().next().value;
        this.map.get(val).delete(indexToRemove);

        const lastElement = this.list[this.list.length - 1];
        this.list[indexToRemove] = lastElement;

        if (this.map.has(lastElement)) {
            this.map.get(lastElement).delete(this.list.length - 1);
            this.map.get(lastElement).add(indexToRemove);
        }

        this.list.pop();
        return true;
    }

    getRandom() {
        return this.list[Math.floor(Math.random() * this.list.length)];
    }
}