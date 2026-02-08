var dieSimulator = function(n, rollMax) {
    const MOD = 1e9 + 7;
    const dp = Array.from({ length: n + 1 }, () => Array.from({ length: 6 }, () => new Array(16).fill(0)));

    for (let j = 0; j < 6; j++) {
        dp[1][j][1] = 1;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 0; j < 6; j++) {
            for (let k = 1; k <= rollMax[j]; k++) {
                if (k === 1) {
                    for (let p = 0; p < 6; p++) {
                        if (p !== j) {
                            for (let m = 1; m <= rollMax[p]; m++) {
                                dp[i][j][k] = (dp[i][j][k] + dp[i - 1][p][m]) % MOD;
                            }
                        }
                    }
                } else {
                    dp[i][j][k] = dp[i - 1][j][k - 1];
                }
            }
        }
    }

    let res = 0;
    for (let j = 0; j < 6; j++) {
        for (let k = 1; k <= rollMax[j]; k++) {
            res = (res + dp[n][j][k]) % MOD;
        }
    }
    return res;
};