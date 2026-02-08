var smallestRangeI = function(nums, k) {
    let min = nums[0];
    let max = nums[0];

    for (let i = 1; i < nums.length; i++) {
        min = Math.min(min, nums[i]);
        max = Math.max(max, nums[i]);
    }

    let diff = max - min;
    if (diff <= 2 * k) {
        return 0;
    } else {
        return diff - 2 * k;
    }
};