var RLEIterator = function(nums) {
    this.nums = nums;
    this.index = 0;
};

RLEIterator.prototype.next = function(n) {
    while (this.index < this.nums.length && n > 0) {
        if (this.nums[this.index] >= n) {
            this.nums[this.index] -= n;
            return this.nums[this.index + 1];
        } else {
            n -= this.nums[this.index];
            this.index += 2;
        }
    }
    return -1;
};