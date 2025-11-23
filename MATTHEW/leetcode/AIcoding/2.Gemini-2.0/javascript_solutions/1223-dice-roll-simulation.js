var dieSimulator = function(n, rollMax) {
    const MOD = 10**9 + 7;
    const dp = Array(n + 1).fill(null).map(() => Array(6).fill(null).map(() => Array(16).fill(0)));

    for (let i = 0; i < 6; i++) {
        dp[1][i][1] = 1;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 0; j < 6; j++) {
            for (let k = 1; k <= rollMax[j]; k++) {
                if (k > 1) {
                    dp[i][j][k] = (dp[i][j][k] + dp[i - 1][j][k - 1]) % MOD;
                } else {
                    let sum = 0;
                    for (let l = 0; l < 6; l++) {
                        if (l !== j) {
                            for (let m = 1; m <= rollMax[l]; m++) {
                                sum = (sum + dp[i - 1][l][m]) % MOD;
                            }
                        }
                    }
                    dp[i][j][k] = (dp[i][j][k] + sum) % MOD;
                }
            }
        }
    }

    let total = 0;
    for (let i = 0; i < 6; i++) {
        for (let j = 1; j <= rollMax[i]; j++) {
            total = (total + dp[n][i][j]) % MOD;
        }
    }

    return total;
};