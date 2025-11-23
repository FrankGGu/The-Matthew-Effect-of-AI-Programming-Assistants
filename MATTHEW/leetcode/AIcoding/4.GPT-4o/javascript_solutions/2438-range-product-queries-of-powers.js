class RangeProductQuery {
    constructor(nums) {
        this.prefix = new Array(nums.length + 1).fill(1);
        for (let i = 1; i <= nums.length; i++) {
            this.prefix[i] = this.prefix[i - 1] * nums[i - 1];
        }
    }

    product(left, right) {
        return this.prefix[right + 1] / this.prefix[left];
    }
}