function minIncrementOperations(nums, k) {
    const n = nums.length;
    const dp = new Array(n).fill(0);

    for (let i = 2; i < n; i++) {
        dp[i] = Math.min(dp[i - 1], dp[i - 2], dp[i - 3]) + Math.max(0, k - nums[i]);
    }

    return Math.min(dp[n - 1], dp[n - 2], dp[n - 3]);
}