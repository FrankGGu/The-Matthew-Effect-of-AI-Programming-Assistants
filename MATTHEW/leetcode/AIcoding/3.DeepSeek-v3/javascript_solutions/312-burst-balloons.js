var maxCoins = function(nums) {
    const n = nums.length;
    const dp = Array.from({ length: n + 2 }, () => new Array(n + 2).fill(0));
    const val = new Array(n + 2);
    val[0] = val[n + 1] = 1;
    for (let i = 1; i <= n; i++) {
        val[i] = nums[i - 1];
    }

    for (let len = 1; len <= n; len++) {
        for (let i = 1; i <= n - len + 1; i++) {
            const j = i + len - 1;
            for (let k = i; k <= j; k++) {
                dp[i][j] = Math.max(dp[i][j], dp[i][k - 1] + val[i - 1] * val[k] * val[j + 1] + dp[k + 1][j]);
            }
        }
    }

    return dp[1][n];
};