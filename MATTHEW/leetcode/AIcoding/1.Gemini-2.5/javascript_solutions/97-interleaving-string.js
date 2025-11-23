var isInterleave = function(s1, s2, s3) {
    const n1 = s1.length;
    const n2 = s2.length;
    const n3 = s3.length;

    if (n1 + n2 !== n3) {
        return false;
    }

    const dp = Array(n1 + 1).fill(false).map(() => Array(n2 + 1).fill(false));

    dp[0][0] = true;

    for (let j = 1; j <= n2; j++) {
        dp[0][j] = dp[0][j - 1] && (s2[j - 1] === s3[j - 1]);
    }

    for (let i = 1; i <= n1; i++) {
        dp[i][0] = dp[i - 1][0] && (s1[i - 1] === s3[i - 1]);
    }

    for (let i = 1; i <= n1; i++) {
        for (let j = 1; j <= n2; j++) {
            dp[i][j] = (dp[i - 1][j] && (s1[i - 1] === s3[i + j - 1])) ||
                       (dp[i][j - 1] && (s2[j - 1] === s3[i + j - 1]));
        }
    }

    return dp[n1][n2];
};