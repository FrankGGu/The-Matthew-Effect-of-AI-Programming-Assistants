var isInterleave = function(s1, s2, s3) {
    const m = s1.length;
    const n = s2.length;
    const l = s3.length;

    if (m + n !== l) {
        return false;
    }

    const dp = Array(m + 1).fill(false).map(() => Array(n + 1).fill(false));

    dp[0][0] = true;

    for (let i = 1; i <= m; i++) {
        dp[i][0] = dp[i - 1][0] && (s1[i - 1] === s3[i - 1]);
    }

    for (let j = 1; j <= n; j++) {
        dp[0][j] = dp[0][j - 1] && (s2[j - 1] === s3[j - 1]);
    }

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            const charS3 = s3[i + j - 1];
            const fromS1 = dp[i - 1][j] && (s1[i - 1] === charS3);
            const fromS2 = dp[i][j - 1] && (s2[j - 1] === charS3);
            dp[i][j] = fromS1 || fromS2;
        }
    }

    return dp[m][n];
};