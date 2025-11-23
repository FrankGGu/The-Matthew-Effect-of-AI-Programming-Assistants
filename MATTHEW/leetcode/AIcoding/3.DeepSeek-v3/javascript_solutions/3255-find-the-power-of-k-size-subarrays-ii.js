var sumOfPowers = function(nums, k) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    let dp = new Array(n + 1).fill().map(() => new Array(k + 1).fill(0).map(() => new Array(2).fill(0)));
    dp[0][0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            for (let t = 0; t < 2; t++) {
                dp[i][j][t] = dp[i - 1][j][t];
                if (j > 0) {
                    dp[i][j][t] = (dp[i][j][t] + dp[i - 1][j - 1][t]) % MOD;
                    if (nums[i - 1] === 0) {
                        dp[i][j][t] = (dp[i][j][t] + dp[i - 1][j - 1][1]) % MOD;
                    } else {
                        dp[i][j][t] = (dp[i][j][t] + dp[i - 1][j - 1][0]) % MOD;
                    }
                }
            }
        }
    }

    return dp[n][k][1];
};