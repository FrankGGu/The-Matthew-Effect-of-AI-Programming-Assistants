var sumOfProbabilities = function(n, k, target) {
    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(0));
    const mod = 1e9 + 7;

    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            for (let x = 1; x <= 6; x++) {
                if (j - x >= 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - x]) % mod;
                }
            }
        }
    }

    let totalWays = Math.pow(6, n);
    return (dp[n][target] / totalWays) % mod;
};