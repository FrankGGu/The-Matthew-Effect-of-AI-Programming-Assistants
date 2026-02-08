var NumArray = function(nums) {
    this.prefixSum = new Array(nums.length + 1);
    this.prefixSum[0] = 0;
    for (let i = 1; i <= nums.length; i++) {
        this.prefixSum[i] = this.prefixSum[i - 1] + nums[i - 1];
    }
};

NumArray.prototype.sumRange = function(left, right) {
    return this.prefixSum[right + 1] - this.prefixSum[left];
};