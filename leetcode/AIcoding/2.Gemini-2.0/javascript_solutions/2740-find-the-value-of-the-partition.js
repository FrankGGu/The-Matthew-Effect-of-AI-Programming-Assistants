var findValueOfPartition = function(nums) {
    nums.sort((a, b) => a - b);
    let minDiff = Infinity;
    for (let i = 0; i < nums.length - 1; i++) {
        minDiff = Math.min(minDiff, Math.abs(nums[i] - nums[i + 1]));
    }
    return minDiff;
};