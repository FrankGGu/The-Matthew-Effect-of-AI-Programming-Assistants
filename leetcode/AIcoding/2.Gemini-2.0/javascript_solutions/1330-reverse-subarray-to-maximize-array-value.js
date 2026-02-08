var maxValueAfterReverse = function(nums) {
    const n = nums.length;
    let initialValue = 0;
    for (let i = 0; i < n - 1; i++) {
        initialValue += Math.abs(nums[i] - nums[i + 1]);
    }

    let maxChange = 0;
    for (let i = 1; i < n - 1; i++) {
        maxChange = Math.max(maxChange, 2 * Math.max(Math.abs(nums[0] - nums[i]), Math.abs(nums[n - 1] - nums[i])));
    }

    let minMax = Infinity;
    let maxMin = -Infinity;
    for (let i = 0; i < n - 1; i++) {
        minMax = Math.min(minMax, Math.max(nums[i], nums[i + 1]));
        maxMin = Math.max(maxMin, Math.min(nums[i], nums[i + 1]));
    }

    maxChange = Math.max(maxChange, 2 * (maxMin - minMax));

    return initialValue + maxChange;
};