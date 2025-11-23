var minDifficulty = function(jobDifficulty, d) {
    const n = jobDifficulty.length;
    if (n < d) return -1;

    const dp = Array.from({ length: d + 1 }, () => Array(n + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let day = 1; day <= d; day++) {
        for (let i = day; i <= n; i++) {
            let max = 0;
            for (let j = i; j >= day; j--) {
                max = Math.max(max, jobDifficulty[j - 1]);
                dp[day][i] = Math.min(dp[day][i], dp[day - 1][j - 1] + max);
            }
        }
    }

    return dp[d][n];
};