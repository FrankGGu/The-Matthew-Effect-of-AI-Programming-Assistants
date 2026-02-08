var numOfArrays = function(n, m, k) {
    const MOD = 1000000007;
    let dp = Array(n + 1).fill(null).map(() => Array(m + 1).fill(null).map(() => Array(k + 1).fill(0)));
    let prefixSum = Array(n + 1).fill(null).map(() => Array(m + 1).fill(null).map(() => Array(k + 1).fill(0)));

    for (let j = 1; j <= m; j++) {
        dp[1][j][1] = 1;
        prefixSum[1][j][1] = (prefixSum[1][j - 1][1] + dp[1][j][1]) % MOD;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            for (let l = 1; l <= k; l++) {
                dp[i][j][l] = (dp[i][j][l] + (dp[i - 1][j][l] * j) % MOD) % MOD;
                dp[i][j][l] = (dp[i][j][l] + prefixSum[i - 1][j - 1][l - 1]) % MOD;
            }
            for (let l = 1; l <= k; l++) {
                prefixSum[i][j][l] = (prefixSum[i][j - 1][l] + dp[i][j][l]) % MOD;
            }
        }
    }

    let result = 0;
    for (let j = 1; j <= m; j++) {
        result = (result + dp[n][j][k]) % MOD;
    }

    return result;
};