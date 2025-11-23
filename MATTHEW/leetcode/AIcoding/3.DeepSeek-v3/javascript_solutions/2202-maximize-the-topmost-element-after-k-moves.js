var maximumTop = function(nums, k) {
    if (nums.length === 1 && k % 2 === 1) return -1;
    let max = -Infinity;
    for (let i = 0; i < Math.min(nums.length, k + 1); i++) {
        if (i !== k - 1) {
            max = Math.max(max, nums[i]);
        }
    }
    return max;
};