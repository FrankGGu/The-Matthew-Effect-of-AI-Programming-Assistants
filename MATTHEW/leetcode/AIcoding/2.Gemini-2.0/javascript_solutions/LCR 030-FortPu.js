var RandomizedSet = function() {
    this.nums = [];
    this.indices = {};
};

RandomizedSet.prototype.insert = function(val) {
    if (this.indices[val] !== undefined) {
        return false;
    }
    this.nums.push(val);
    this.indices[val] = this.nums.length - 1;
    return true;
};

RandomizedSet.prototype.remove = function(val) {
    if (this.indices[val] === undefined) {
        return false;
    }
    const index = this.indices[val];
    const lastElement = this.nums[this.nums.length - 1];
    this.nums[index] = lastElement;
    this.indices[lastElement] = index;
    this.nums.pop();
    delete this.indices[val];
    return true;
};

RandomizedSet.prototype.getRandom = function() {
    const randomIndex = Math.floor(Math.random() * this.nums.length);
    return this.nums[randomIndex];
};