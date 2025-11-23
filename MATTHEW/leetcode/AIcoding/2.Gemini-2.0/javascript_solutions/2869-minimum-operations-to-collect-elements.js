var minOperations = function(nums, k) {
    let count = 0;
    let collected = new Set();
    for (let i = nums.length - 1; i >= 0; i--) {
        if (nums[i] <= k) {
            collected.add(nums[i]);
        }
        count++;
        if (collected.size === k) {
            return count;
        }
    }
    return count;
};