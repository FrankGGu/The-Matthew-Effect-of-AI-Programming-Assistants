var minimizeSum = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const option1 = nums[n - 1] - nums[2];
    const option2 = nums[n - 2] - nums[1];
    const option3 = nums[n - 3] - nums[0];
    return Math.min(option1, option2, option3);
};