var checkRecord = function(n) {
    const MOD = 1000000007;
    let dp = Array(n + 1).fill(null).map(() => Array(2).fill(null).map(() => Array(3).fill(0)));

    dp[0][0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j < 2; j++) {
            for (let k = 0; k < 3; k++) {
                // Present
                dp[i][j][0] = (dp[i][j][0] + dp[i - 1][j][k]) % MOD;

                // Absent
                if (j === 0) {
                    dp[i][1][0] = (dp[i][1][0] + dp[i - 1][j][k]) % MOD;
                }

                // Late
                if (k < 2) {
                    dp[i][j][k + 1] = (dp[i][j][k + 1] + dp[i - 1][j][k]) % MOD;
                }
            }
        }
    }

    let sum = 0;
    for (let j = 0; j < 2; j++) {
        for (let k = 0; k < 3; k++) {
            sum = (sum + dp[n][j][k]) % MOD;
        }
    }

    return sum;
};