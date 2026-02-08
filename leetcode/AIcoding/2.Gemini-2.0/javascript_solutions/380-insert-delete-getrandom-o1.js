var RandomizedSet = function() {
    this.nums = [];
    this.map = new Map();
};

RandomizedSet.prototype.insert = function(val) {
    if (this.map.has(val)) {
        return false;
    }
    this.nums.push(val);
    this.map.set(val, this.nums.length - 1);
    return true;
};

RandomizedSet.prototype.remove = function(val) {
    if (!this.map.has(val)) {
        return false;
    }
    let index = this.map.get(val);
    let last = this.nums[this.nums.length - 1];
    this.nums[index] = last;
    this.map.set(last, index);
    this.nums.pop();
    this.map.delete(val);
    return true;
};

RandomizedSet.prototype.getRandom = function() {
    let randomIndex = Math.floor(Math.random() * this.nums.length);
    return this.nums[randomIndex];
};