var RandomizedCollection = function() {
    this.map = new Map();
    this.list = [];
};

RandomizedCollection.prototype.insert = function(val) {
    const hasVal = this.map.has(val);
    if (!hasVal) {
        this.map.set(val, new Set());
    }
    this.map.get(val).add(this.list.length);
    this.list.push(val);
    return !hasVal;
};

RandomizedCollection.prototype.remove = function(val) {
    if (!this.map.has(val)) return false;
    const indices = this.map.get(val);
    const indexToRemove = indices.values().next().value;
    indices.delete(indexToRemove);
    if (indices.size === 0) {
        this.map.delete(val);
    }
    if (indexToRemove !== this.list.length - 1) {
        const lastVal = this.list[this.list.length - 1];
        this.list[indexToRemove] = lastVal;
        const lastValIndices = this.map.get(lastVal);
        lastValIndices.delete(this.list.length - 1);
        lastValIndices.add(indexToRemove);
    }
    this.list.pop();
    return true;
};

RandomizedCollection.prototype.getRandom = function() {
    const randomIndex = Math.floor(Math.random() * this.list.length);
    return this.list[randomIndex];
};