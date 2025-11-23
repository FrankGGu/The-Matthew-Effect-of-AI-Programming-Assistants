function distinctRolls(n) {
    const MOD = 1000000007;
    const dp = new Array(n + 1).fill(0).map(() => new Array(7).fill(0));
    for (let i = 1; i <= 6; i++) {
        dp[1][i] = 1;
    }
    for (let i = 2; i <= n; i++) {
        for (let j = 1; j <= 6; j++) {
            for (let k = 1; k <= 6; k++) {
                if (k !== j) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                }
            }
        }
    }
    let result = 0;
    for (let i = 1; i <= 6; i++) {
        result = (result + dp[n][i]) % MOD;
    }
    return result;
}