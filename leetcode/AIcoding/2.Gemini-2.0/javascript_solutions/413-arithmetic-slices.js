var numberOfArithmeticSlices = function(nums) {
    let n = nums.length;
    if (n < 3) return 0;

    let dp = new Array(n).fill(0);
    let ans = 0;

    for (let i = 2; i < n; i++) {
        if (nums[i] - nums[i - 1] === nums[i - 1] - nums[i - 2]) {
            dp[i] = dp[i - 1] + 1;
            ans += dp[i];
        }
    }

    return ans;
};