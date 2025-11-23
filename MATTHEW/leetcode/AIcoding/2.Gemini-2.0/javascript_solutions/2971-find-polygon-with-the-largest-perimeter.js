var largestPerimeter = function(nums) {
    nums.sort((a, b) => a - b);
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
    }

    for (let i = nums.length - 1; i >= 2; i--) {
        sum -= nums[i];
        if (nums[i] < sum) {
            return sum + nums[i];
        }
    }

    return -1;
};