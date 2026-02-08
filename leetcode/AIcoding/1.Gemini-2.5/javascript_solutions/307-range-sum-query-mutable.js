var NumArray = function(nums) {
    this.nums = nums;
    this.n = nums.length;
    this.bit = new Array(this.n + 1).fill(0);

    for (let i = 0; i < this.n; i++) {
        this._add(i + 1, nums[i]);
    }
};

NumArray.prototype._add = function(idx, val) {
    while (idx <= this.n) {
        this.bit[idx] += val;
        idx += idx & (-idx);
    }
};

NumArray.prototype._prefixSum = function(idx) {
    let sum = 0;
    while (idx > 0) {
        sum += this.bit[idx];
        idx -= idx & (-idx);
    }
    return sum;
};

NumArray.prototype.update = function(index, val) {
    let diff = val - this.nums[index];
    this.nums[index] = val;
    this._add(index + 1, diff);
};

NumArray.prototype.sumRange = function(left, right) {
    return this._prefixSum(right + 1) - this._prefixSum(left);
};