var minIncrementToMakeArrayUnique = function(nums) {
    nums.sort((a, b) => a - b);
    let increments = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] <= nums[i - 1]) {
            increments += nums[i - 1] - nums[i] + 1;
            nums[i] = nums[i - 1] + 1;
        }
    }
    return increments;
};