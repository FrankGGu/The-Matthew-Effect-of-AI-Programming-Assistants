var Solution = function(nums) {
    this.nums = nums;
    this.original = [...nums];
};

Solution.prototype.reset = function() {
    this.nums = [...this.original];
    return this.nums;
};

Solution.prototype.shuffle = function() {
    for (let i = this.nums.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [this.nums[i], this.nums[j]] = [this.nums[j], this.nums[i]];
    }
    return this.nums;
};