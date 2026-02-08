var maxAbsoluteSum = function(nums) {
    let max_so_far = nums[0];
    let current_max = nums[0];

    let min_so_far = nums[0];
    let current_min = nums[0];

    for (let i = 1; i < nums.length; i++) {
        current_max = Math.max(nums[i], current_max + nums[i]);
        max_so_far = Math.max(max_so_far, current_max);

        current_min = Math.min(nums[i], current_min + nums[i]);
        min_so_far = Math.min(min_so_far, current_min);
    }

    return Math.max(max_so_far, Math.abs(min_so_far));
};