var countArrays = function(n, k) {
    const mod = 1e9 + 7;
    let dp = new Array(n + 1).fill(0).map(() => new Array(k + 1).fill(0));

    for (let j = 1; j <= k; j++) {
        dp[1][j] = j;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = (dp[i - 1][j] * (j - 1) + dp[i - 1][j - 1]) % mod;
        }
    }

    let result = 0;
    for (let j = 1; j <= k; j++) {
        result = (result + dp[n][j]) % mod;
    }

    return result;
};