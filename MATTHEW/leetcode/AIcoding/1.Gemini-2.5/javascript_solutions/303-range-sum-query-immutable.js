var NumArray = function(nums) {
    this.prefixSums = new Array(nums.length + 1).fill(0);
    for (let i = 0; i < nums.length; i++) {
        this.prefixSums[i + 1] = this.prefixSums[i] + nums[i];
    }
};

NumArray.prototype.sumRange = function(left, right) {
    return this.prefixSums[right + 1] - this.prefixSums[left];
};