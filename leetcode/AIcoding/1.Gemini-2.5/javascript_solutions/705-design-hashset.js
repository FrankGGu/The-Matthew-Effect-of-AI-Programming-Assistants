var MyHashSet = function() {
    this.data = new Array(1000001).fill(false);
};

MyHashSet.prototype.add = function(key) {
    this.data[key] = true;
};

MyHashSet.prototype.remove = function(key) {
    this.data[key] = false;
};

MyHashSet.prototype.contains = function(key) {
    return this.data[key];
};