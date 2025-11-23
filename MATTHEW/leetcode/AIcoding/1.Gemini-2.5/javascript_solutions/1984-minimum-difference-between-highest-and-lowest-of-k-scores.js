var minimumDifference = function(nums, k) {
    if (k === 1) {
        return 0;
    }

    nums.sort((a, b) => a - b);

    let minDiff = Infinity;

    for (let i = 0; i <= nums.length - k; i++) {
        const currentDiff = nums[i + k - 1] - nums[i];
        if (currentDiff < minDiff) {
            minDiff = currentDiff;
        }
    }

    return minDiff;
};