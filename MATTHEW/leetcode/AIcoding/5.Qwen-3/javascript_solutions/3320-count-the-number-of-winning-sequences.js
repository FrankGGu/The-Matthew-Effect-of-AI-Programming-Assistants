function countTheNumberofWinningSequences(s) {
    const MOD = 1000000007;
    const dp = Array.from({ length: 11 }, () => Array(11).fill(0));
    dp[0][0] = 1;
    for (let i = 1; i <= 10; i++) {
        for (let j = 0; j <= i; j++) {
            for (let k = 0; k <= j; k++) {
                if (j - k >= 0 && i - k >= 0) {
                    dp[i][j] = (dp[i][j] + dp[i - k][j - k]) % MOD;
                }
            }
        }
    }
    return dp[10][10];
}