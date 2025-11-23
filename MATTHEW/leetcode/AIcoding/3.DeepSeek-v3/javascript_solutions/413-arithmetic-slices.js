var numberOfArithmeticSlices = function(nums) {
    let count = 0;
    let dp = 0;
    for (let i = 2; i < nums.length; i++) {
        if (nums[i] - nums[i - 1] === nums[i - 1] - nums[i - 2]) {
            dp = dp + 1;
            count += dp;
        } else {
            dp = 0;
        }
    }
    return count;
};