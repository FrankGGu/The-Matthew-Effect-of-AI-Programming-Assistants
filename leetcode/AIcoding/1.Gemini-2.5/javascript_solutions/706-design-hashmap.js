var MyHashMap = function() {
    this.buckets = new Array(1000);
    this.bucketSize = 1000;
};

MyHashMap.prototype.put = function(key, value) {
    const hash = key % this.bucketSize;
    if (!this.buckets[hash]) {
        this.buckets[hash] = [];
    }

    const bucket = this.buckets[hash];
    for (let i = 0; i < bucket.length; i++) {
        if (bucket[i][0] === key) {
            bucket[i][1] = value;
            return;
        }
    }
    bucket.push([key, value]);
};

MyHashMap.prototype.get = function(key) {
    const hash = key % this.bucketSize;
    const bucket = this.buckets[hash];

    if (!bucket) {
        return -1;
    }

    for (let i = 0; i < bucket.length; i++) {
        if (bucket[i][0] === key) {
            return bucket[i][1];
        }
    }
    return -1;
};

MyHashMap.prototype.remove = function(key) {
    const hash = key % this.bucketSize;
    const bucket = this.buckets[hash];

    if (!bucket) {
        return;
    }

    for (let i = 0; i < bucket.length; i++) {
        if (bucket[i][0] === key) {
            bucket.splice(i, 1);
            return;
        }
    }
};