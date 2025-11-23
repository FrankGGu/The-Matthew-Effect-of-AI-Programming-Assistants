var stableBinArray = function(limit, one, zero) {
    const MOD = 1e9 + 7;
    let dp = new Array(one + 1).fill().map(() => new Array(zero + 1).fill().map(() => new Array(2).fill(0)));

    for (let i = 0; i <= one; i++) {
        for (let j = 0; j <= zero; j++) {
            if (i === 0 && j === 0) continue;
            if (i > 0) {
                if (i === 1 && j === 0) {
                    dp[i][j][0] = 1;
                } else {
                    dp[i][j][0] = (dp[i-1][j][1]) % MOD;
                    if (i > 1) {
                        dp[i][j][0] = (dp[i][j][0] + dp[i-1][j][0]) % MOD;
                    }
                }
            }
            if (j > 0) {
                if (j === 1 && i === 0) {
                    dp[i][j][1] = 1;
                } else {
                    dp[i][j][1] = (dp[i][j-1][0]) % MOD;
                    if (j > 1) {
                        dp[i][j][1] = (dp[i][j][1] + dp[i][j-1][1]) % MOD;
                    }
                }
            }
        }
    }

    let res = 0;
    for (let i = 0; i <= one; i++) {
        for (let j = 0; j <= zero; j++) {
            if (i + j < limit) continue;
            res = (res + dp[i][j][0] + dp[i][j][1]) % MOD;
        }
    }
    return res;
};