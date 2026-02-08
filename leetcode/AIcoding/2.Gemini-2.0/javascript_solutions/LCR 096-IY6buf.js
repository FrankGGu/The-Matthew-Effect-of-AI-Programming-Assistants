var isInterleave = function(s1, s2, s3) {
    const m = s1.length;
    const n = s2.length;
    const len = s3.length;

    if (m + n !== len) {
        return false;
    }

    const dp = Array(m + 1).fill(null).map(() => Array(n + 1).fill(false));

    dp[0][0] = true;

    for (let i = 0; i <= m; i++) {
        for (let j = 0; j <= n; j++) {
            if (i > 0 && s1[i - 1] === s3[i + j - 1]) {
                dp[i][j] = dp[i][j] || dp[i - 1][j];
            }
            if (j > 0 && s2[j - 1] === s3[i + j - 1]) {
                dp[i][j] = dp[i][j] || dp[i][j - 1];
            }
        }
    }

    return dp[m][n];
};