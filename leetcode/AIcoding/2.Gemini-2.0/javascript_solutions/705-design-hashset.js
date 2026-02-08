class MyHashSet {
    constructor() {
        this.buckets = new Array(1000).fill(null);
    }

    hash(key) {
        return key % 1000;
    }

    add(key) {
        const index = this.hash(key);
        if (!this.buckets[index]) {
            this.buckets[index] = [];
        }
        if (!this.buckets[index].includes(key)) {
            this.buckets[index].push(key);
        }
    }

    remove(key) {
        const index = this.hash(key);
        if (this.buckets[index]) {
            this.buckets[index] = this.buckets[index].filter(val => val !== key);
        }
    }

    contains(key) {
        const index = this.hash(key);
        return this.buckets[index] && this.buckets[index].includes(key);
    }
}