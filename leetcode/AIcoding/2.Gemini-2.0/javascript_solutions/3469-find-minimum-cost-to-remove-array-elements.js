var minCost = function(nums) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = n - 1; i >= 0; i--) {
        dp[i] = Math.min(nums[i] + dp[i + 1], i + 1 < n ? nums[i] + nums[i + 1] + (i + 2 < n ? dp[i + 2] : 0) : nums[i]);
    }

    return dp[0];
};