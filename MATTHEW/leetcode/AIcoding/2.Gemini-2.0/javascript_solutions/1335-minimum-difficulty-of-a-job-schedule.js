var minDifficulty = function(jobDifficulty, d) {
    const n = jobDifficulty.length;
    if (n < d) return -1;

    const dp = Array(d + 1).fill(null).map(() => Array(n + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= d; i++) {
        for (let j = i; j <= n; j++) {
            let maxDifficulty = 0;
            for (let k = j; k >= i; k--) {
                maxDifficulty = Math.max(maxDifficulty, jobDifficulty[k - 1]);
                dp[i][j] = Math.min(dp[i][j], dp[i - 1][k - 1] + maxDifficulty);
            }
        }
    }

    return dp[d][n];
};