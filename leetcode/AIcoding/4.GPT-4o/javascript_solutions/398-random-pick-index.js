class Solution {
    constructor(nums) {
        this.nums = nums;
    }

    pick(target) {
        let count = 0, index = -1;
        for (let i = 0; i < this.nums.length; i++) {
            if (this.nums[i] === target) {
                count++;
                if (Math.random() < 1 / count) {
                    index = i;
                }
            }
        }
        return index;
    }
}