function minCost(n, cuts) {
    cuts.sort((a, b) => a - b);
    const m = cuts.length;
    const dp = Array(m + 2).fill().map(() => Array(m + 2).fill(0));

    for (let length = 2; length <= m; length++) {
        for (let i = 0; i + length <= m; i++) {
            let j = i + length;
            dp[i][j] = Infinity;
            for (let k = i; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + (cuts[j] - cuts[i]));
            }
        }
    }

    return dp[0][m];
}