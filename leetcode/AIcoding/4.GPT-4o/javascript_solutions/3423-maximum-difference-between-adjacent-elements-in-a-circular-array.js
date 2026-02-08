var maxAbsoluteDiff = function(nums) {
    let maxDiff = 0;
    let n = nums.length;

    for (let i = 0; i < n; i++) {
        let diff = Math.abs(nums[i] - nums[(i + 1) % n]);
        maxDiff = Math.max(maxDiff, diff);
    }

    return maxDiff;
};