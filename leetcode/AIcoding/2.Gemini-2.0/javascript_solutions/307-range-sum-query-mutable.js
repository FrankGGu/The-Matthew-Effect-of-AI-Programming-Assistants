var NumArray = function(nums) {
    this.nums = nums;
    this.sum = new Array(nums.length + 1).fill(0);
    for (let i = 0; i < nums.length; i++) {
        this.sum[i + 1] = this.sum[i] + nums[i];
    }
};

NumArray.prototype.update = function(index, val) {
    let diff = val - this.nums[index];
    this.nums[index] = val;
    for (let i = index + 1; i < this.sum.length; i++) {
        this.sum[i] += diff;
    }
};

NumArray.prototype.sumRange = function(left, right) {
    return this.sum[right + 1] - this.sum[left];
};