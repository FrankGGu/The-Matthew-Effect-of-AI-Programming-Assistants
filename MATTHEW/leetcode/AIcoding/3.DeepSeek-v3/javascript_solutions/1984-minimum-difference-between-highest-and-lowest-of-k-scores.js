var minimumDifference = function(nums, k) {
    nums.sort((a, b) => a - b);
    let minDiff = Infinity;
    for (let i = 0; i <= nums.length - k; i++) {
        let currentDiff = nums[i + k - 1] - nums[i];
        if (currentDiff < minDiff) {
            minDiff = currentDiff;
        }
    }
    return minDiff;
};