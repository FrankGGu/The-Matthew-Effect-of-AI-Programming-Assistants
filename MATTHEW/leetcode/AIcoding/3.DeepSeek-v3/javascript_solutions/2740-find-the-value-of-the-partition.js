var findValueOfPartition = function(nums) {
    nums.sort((a, b) => a - b);
    let minDiff = Infinity;
    for (let i = 1; i < nums.length; i++) {
        const diff = nums[i] - nums[i - 1];
        if (diff < minDiff) {
            minDiff = diff;
        }
    }
    return minDiff;
};