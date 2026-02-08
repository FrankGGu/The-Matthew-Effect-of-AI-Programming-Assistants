var dieSimulator = function(n) {
    const MOD = 10**9 + 7;
    const dp = Array.from({ length: n + 1 }, () => Array(6).fill(0));

    for (let i = 0; i < 6; i++) {
        dp[0][i] = 1;
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j < 6; j++) {
            for (let k = 0; k < 6; k++) {
                if (j !== k) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                }
            }
        }
    }

    return dp[n].reduce((a, b) => (a + b) % MOD, 0);
};