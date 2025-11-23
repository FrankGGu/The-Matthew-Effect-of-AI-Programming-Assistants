function minArraySum(nums, k, target) {
    const n = nums.length;
    const dp = new Array(n).fill(0).map(() => new Array(k + 1).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][0] = nums[i];
    }

    for (let i = 1; i < n; i++) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = Math.min(dp[i - 1][j - 1] + nums[i], dp[i - 1][j] + nums[i]);
        }
    }

    return dp[n - 1][k];
}