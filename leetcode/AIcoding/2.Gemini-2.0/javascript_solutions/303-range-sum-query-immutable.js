var NumArray = function(nums) {
    this.sums = new Array(nums.length + 1).fill(0);
    for (let i = 0; i < nums.length; i++) {
        this.sums[i + 1] = this.sums[i] + nums[i];
    }
};

NumArray.prototype.sumRange = function(left, right) {
    return this.sums[right + 1] - this.sums[left];
};