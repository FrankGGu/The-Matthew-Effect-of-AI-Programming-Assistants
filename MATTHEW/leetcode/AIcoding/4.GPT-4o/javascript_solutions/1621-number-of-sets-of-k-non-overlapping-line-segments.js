var countWays = function(segments, k) {
    const MOD = 1e9 + 7;
    const n = segments.length;
    const dp = Array.from({ length: k + 1 }, () => Array(n + 1).fill(0));
    const sum = Array.from({ length: k + 1 }, () => Array(n + 1).fill(0));

    for (let i = 0; i <= n; i++) {
        dp[0][i] = 1;
    }

    for (let i = 1; i <= k; i++) {
        for (let j = 1; j <= n; j++) {
            const [l, r] = segments[j - 1];
            dp[i][j] = sum[i - 1][j - 1] % MOD;
            sum[i][j] = (sum[i][j - 1] + dp[i][j]) % MOD;

            for (let m = 1; m < j; m++) {
                if (segments[m - 1][1] < l) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][m]) % MOD;
                }
            }
        }
    }

    return dp[k][n];
};