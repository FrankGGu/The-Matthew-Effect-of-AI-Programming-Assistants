function minDifficulty(jobDifficulty, d) {
    const n = jobDifficulty.length;
    if (n < d) return -1;

    const dp = new Array(n + 1).fill(0).map(() => new Array(d + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let k = 1; k <= d; k++) {
            let maxDiff = 0;
            for (let j = i - 1; j >= k - 1; j--) {
                maxDiff = Math.max(maxDiff, jobDifficulty[j]);
                dp[i][k] = Math.min(dp[i][k], dp[j][k - 1] + maxDiff);
            }
        }
    }

    return dp[n][d];
}