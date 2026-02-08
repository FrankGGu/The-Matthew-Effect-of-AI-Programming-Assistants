class NumArray {
    constructor(nums) {
        this.nums = nums;
        this.prefixSum = new Array(nums.length + 1).fill(0);
        for (let i = 0; i < nums.length; i++) {
            this.prefixSum[i + 1] = this.prefixSum[i] + nums[i];
        }
    }

    update(index, val) {
        const diff = val - this.nums[index];
        this.nums[index] = val;
        for (let i = index + 1; i < this.prefixSum.length; i++) {
            this.prefixSum[i] += diff;
        }
    }

    sumRange(left, right) {
        return this.prefixSum[right + 1] - this.prefixSum[left];
    }
}