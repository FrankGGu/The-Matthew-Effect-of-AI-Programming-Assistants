var maxValueAfterReverse = function(nums) {
    let maxDiff = 0, maxA = nums[0], minA = nums[0];
    let n = nums.length;

    for (let i = 1; i < n; i++) {
        maxDiff = Math.max(maxDiff, Math.abs(nums[i] - nums[i - 1]));
        maxA = Math.max(maxA, nums[i]);
        minA = Math.min(minA, nums[i]);
    }

    let initialValue = Math.max(...nums) - Math.min(...nums);

    for (let i = 1; i < n; i++) {
        maxDiff = Math.max(maxDiff, Math.abs(nums[i] - minA), Math.abs(maxA - nums[i]));
    }

    return initialValue + maxDiff;
};