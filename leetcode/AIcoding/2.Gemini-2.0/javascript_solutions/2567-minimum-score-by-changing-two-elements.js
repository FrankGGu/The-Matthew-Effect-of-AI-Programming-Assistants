var minimizeSum = function(nums) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let ans = Math.min(nums[n - 1] - nums[2], nums[n - 3] - nums[0]);
    ans = Math.min(ans, nums[n - 2] - nums[1]);
    return ans;
};