var maxDistance = function(nums) {
    let n = nums.length;
    let maxDiff = 0;

    for (let i = 0; i < n; i++) {
        let diff = Math.abs(nums[i] - nums[(i + 1) % n]);
        maxDiff = Math.max(maxDiff, diff);
    }

    return maxDiff;
};