var RandomizedSet = function() {
    this.map = new Map();
    this.list = [];
};

RandomizedSet.prototype.insert = function(val) {
    if (this.map.has(val)) return false;
    this.map.set(val, this.list.length);
    this.list.push(val);
    return true;
};

RandomizedSet.prototype.remove = function(val) {
    if (!this.map.has(val)) return false;
    const index = this.map.get(val);
    const lastElement = this.list[this.list.length - 1];
    this.list[index] = lastElement;
    this.map.set(lastElement, index);
    this.list.pop();
    this.map.delete(val);
    return true;
};

RandomizedSet.prototype.getRandom = function() {
    return this.list[Math.floor(Math.random() * this.list.length)];
};