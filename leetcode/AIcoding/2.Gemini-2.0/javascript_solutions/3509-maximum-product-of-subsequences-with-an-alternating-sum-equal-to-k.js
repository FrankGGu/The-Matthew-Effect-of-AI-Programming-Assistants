var maxProduct = function(nums, k) {
    const MOD = 10**9 + 7;
    const n = nums.length;
    const dp = Array(n + 1).fill(null).map(() => Array(2 * k + 1).fill(-Infinity));
    dp[0][k] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= 2 * k; j++) {
            dp[i][j] = dp[i - 1][j];

            if (j - nums[i - 1] >= 0) {
                dp[i][j] = Math.max(dp[i][j], (dp[i - 1][j - nums[i - 1]] * nums[i - 1]) % MOD);
            }

            if (j + nums[i - 1] <= 2 * k) {
                dp[i][j] = Math.max(dp[i][j], (dp[i - 1][j + nums[i - 1]] * nums[i - 1]) % MOD);
            }
        }
    }

    let result = dp[n][k];
    if (result === -Infinity) return -1;
    return result;
};