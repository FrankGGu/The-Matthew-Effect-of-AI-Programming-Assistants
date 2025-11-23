var RandomizedCollection = function() {
    this.nums = [];
    this.map = {};
};

RandomizedCollection.prototype.insert = function(val) {
    if (!this.map[val]) {
        this.map[val] = [];
    }
    this.map[val].push(this.nums.length);
    this.nums.push(val);
    return this.map[val].length === 1;
};

RandomizedCollection.prototype.remove = function(val) {
    if (!this.map[val] || this.map[val].length === 0) {
        return false;
    }
    const index = this.map[val].pop();
    const last = this.nums[this.nums.length - 1];
    if (index !== this.nums.length - 1) {
        this.nums[index] = last;
        const lastIndex = this.map[last].pop();
        this.map[last].push(index);
    }
    this.nums.pop();
    return true;
};

RandomizedCollection.prototype.getRandom = function() {
    return this.nums[Math.floor(Math.random() * this.nums.length)];
};