var findValueOfPartition = function(nums) {
    nums.sort((a, b) => a - b);
    let minDiff = Infinity;
    for (let i = 1; i < nums.length; i++) {
        minDiff = Math.min(minDiff, nums[i] - nums[i - 1]);
    }
    return minDiff;
};