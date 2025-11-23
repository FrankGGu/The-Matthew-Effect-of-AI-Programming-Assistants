var MyHashMap = function() {
    this.size = 1000;
    this.buckets = new Array(this.size).fill(null).map(() => []);
};

MyHashMap.prototype.put = function(key, value) {
    const index = key % this.size;
    const bucket = this.buckets[index];
    for (let i = 0; i < bucket.length; i++) {
        if (bucket[i][0] === key) {
            bucket[i][1] = value;
            return;
        }
    }
    bucket.push([key, value]);
};

MyHashMap.prototype.get = function(key) {
    const index = key % this.size;
    const bucket = this.buckets[index];
    for (let i = 0; i < bucket.length; i++) {
        if (bucket[i][0] === key) {
            return bucket[i][1];
        }
    }
    return -1;
};

MyHashMap.prototype.remove = function(key) {
    const index = key % this.size;
    const bucket = this.buckets[index];
    for (let i = 0; i < bucket.length; i++) {
        if (bucket[i][0] === key) {
            bucket.splice(i, 1);
            return;
        }
    }
};