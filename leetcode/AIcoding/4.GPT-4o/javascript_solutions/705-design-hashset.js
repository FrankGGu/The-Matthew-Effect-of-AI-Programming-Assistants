class MyHashSet {
    constructor() {
        this.buckets = Array(1000).fill().map(() => []);
    }

    add(key) {
        const bucketIndex = key % 1000;
        if (!this.buckets[bucketIndex].includes(key)) {
            this.buckets[bucketIndex].push(key);
        }
    }

    remove(key) {
        const bucketIndex = key % 1000;
        const index = this.buckets[bucketIndex].indexOf(key);
        if (index !== -1) {
            this.buckets[bucketIndex].splice(index, 1);
        }
    }

    contains(key) {
        const bucketIndex = key % 1000;
        return this.buckets[bucketIndex].includes(key);
    }
}