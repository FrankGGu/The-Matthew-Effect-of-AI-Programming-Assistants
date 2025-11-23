var numOfArrays = function(n, m, k) {
    const MOD = 1e9 + 7;
    let dp = Array.from({ length: n + 1 }, () => 
        Array.from({ length: m + 1 }, () => 
            Array(k + 1).fill(0)
        )
    );
    let prefix = Array.from({ length: n + 1 }, () => 
        Array.from({ length: m + 1 }, () => 
            Array(k + 1).fill(0)
        )
    );
    let res = 0;

    for (let j = 1; j <= m; j++) {
        dp[1][j][1] = 1;
        prefix[1][j][1] = (prefix[1][j - 1][1] + dp[1][j][1]) % MOD;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            for (let l = 1; l <= k; l++) {
                dp[i][j][l] = (dp[i - 1][j][l] * j) % MOD;
                dp[i][j][l] = (dp[i][j][l] + prefix[i - 1][j - 1][l - 1]) % MOD;
                prefix[i][j][l] = (prefix[i][j - 1][l] + dp[i][j][l]) % MOD;
            }
        }
    }

    for (let j = 1; j <= m; j++) {
        res = (res + dp[n][j][k]) % MOD;
    }

    return res;
};