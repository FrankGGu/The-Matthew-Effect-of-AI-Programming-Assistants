function numberOfWays(nums, k) {
    const dp = new Array(k + 1).fill(0);
    dp[0] = 1;
    for (const num of nums) {
        for (let i = k; i >= num; i--) {
            dp[i] += dp[i - num];
        }
    }
    return dp[k];
}