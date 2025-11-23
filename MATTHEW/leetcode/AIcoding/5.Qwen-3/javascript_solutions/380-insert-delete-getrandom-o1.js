var RandomizedSet = function() {
    this.nums = [];
    this.indexMap = {};
};

RandomizedSet.prototype.insert = function(val) {
    if (this.indexMap.hasOwnProperty(val)) {
        return false;
    }
    this.nums.push(val);
    this.indexMap[val] = this.nums.length - 1;
    return true;
};

RandomizedSet.prototype.remove = function(val) {
    if (!this.indexMap.hasOwnProperty(val)) {
        return false;
    }
    const lastNum = this.nums[this.nums.length - 1];
    const index = this.indexMap[val];
    this.nums[index] = lastNum;
    this.indexMap[lastNum] = index;
    this.nums.pop();
    delete this.indexMap[val];
    return true;
};

RandomizedSet.prototype.getRandom = function() {
    return this.nums[Math.floor(Math.random() * this.nums.length)];
};