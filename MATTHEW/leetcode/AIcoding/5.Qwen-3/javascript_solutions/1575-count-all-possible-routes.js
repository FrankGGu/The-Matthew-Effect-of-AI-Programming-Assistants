function countRoutes(n, k) {
    const MOD = 10 ** 9 + 7;
    const dp = Array.from({ length: n }, () => Array(k + 1).fill(0));
    for (let i = 0; i < n; i++) {
        dp[i][0] = 1;
    }
    for (let j = 1; j <= k; j++) {
        for (let i = 0; i < n; i++) {
            for (let l = 0; l < n; l++) {
                if (i !== l) {
                    dp[i][j] = (dp[i][j] + dp[l][j - 1]) % MOD;
                }
            }
        }
    }
    let result = 0;
    for (let i = 0; i < n; i++) {
        result = (result + dp[i][k]) % MOD;
    }
    return result;
}