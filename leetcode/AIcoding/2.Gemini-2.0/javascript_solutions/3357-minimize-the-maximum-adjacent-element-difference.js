var minimizeMax = function(nums) {
    nums.sort((a, b) => a - b);
    let maxDiff = 0;
    for (let i = 1; i < nums.length; i++) {
        maxDiff = Math.max(maxDiff, nums[i] - nums[i - 1]);
    }
    return maxDiff;
};