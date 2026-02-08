var findPaths = function(m, n, maxMove, startRow, startColumn) {
    const MOD = 1e9 + 7;
    const dp = Array.from({ length: m }, () => Array.from({ length: n }, () => Array(maxMove + 1).fill(0)));

    for (let k = 1; k <= maxMove; k++) {
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (i === 0) dp[i][j][k] = (dp[i][j][k] + 1) % MOD;
                if (i === m - 1) dp[i][j][k] = (dp[i][j][k] + 1) % MOD;
                if (j === 0) dp[i][j][k] = (dp[i][j][k] + 1) % MOD;
                if (j === n - 1) dp[i][j][k] = (dp[i][j][k] + 1) % MOD;

                if (i > 0) dp[i][j][k] = (dp[i][j][k] + dp[i - 1][j][k - 1]) % MOD;
                if (i < m - 1) dp[i][j][k] = (dp[i][j][k] + dp[i + 1][j][k - 1]) % MOD;
                if (j > 0) dp[i][j][k] = (dp[i][j][k] + dp[i][j - 1][k - 1]) % MOD;
                if (j < n - 1) dp[i][j][k] = (dp[i][j][k] + dp[i][j + 1][k - 1]) % MOD;
            }
        }
    }

    return dp[startRow][startColumn].reduce((sum, count) => (sum + count) % MOD, 0);
};