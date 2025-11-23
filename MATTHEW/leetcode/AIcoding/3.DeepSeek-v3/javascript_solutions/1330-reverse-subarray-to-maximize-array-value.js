var maxValueAfterReverse = function(nums) {
    let total = 0;
    let n = nums.length;
    for (let i = 0; i < n - 1; i++) {
        total += Math.abs(nums[i] - nums[i + 1]);
    }

    let min1 = Infinity, max1 = -Infinity;
    for (let i = 0; i < n; i++) {
        if (i < n - 1) {
            min1 = Math.min(min1, Math.max(nums[i], nums[i + 1]));
            max1 = Math.max(max1, Math.min(nums[i], nums[i + 1]));
        }
    }
    let diff = Math.max(0, (max1 - min1) * 2);

    let edgeDiff = 0;
    for (let i = 0; i < n; i++) {
        if (i > 0) {
            edgeDiff = Math.max(edgeDiff, Math.abs(nums[i] - nums[0]) - Math.abs(nums[i] - nums[i - 1]));
        }
        if (i < n - 1) {
            edgeDiff = Math.max(edgeDiff, Math.abs(nums[i] - nums[n - 1]) - Math.abs(nums[i] - nums[i + 1]));
        }
    }

    return total + Math.max(diff, edgeDiff);
};