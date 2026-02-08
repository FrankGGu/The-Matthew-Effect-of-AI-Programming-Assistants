var isInterleave = function(s1, s2, s3) {
    const len1 = s1.length;
    const len2 = s2.length;
    const len3 = s3.length;

    if (len1 + len2 !== len3) {
        return false;
    }

    const dp = Array(len1 + 1).fill(null).map(() => Array(len2 + 1).fill(false));

    dp[0][0] = true;

    for (let i = 0; i <= len1; i++) {
        for (let j = 0; j <= len2; j++) {
            if (i > 0 && s1[i - 1] === s3[i + j - 1]) {
                dp[i][j] = dp[i][j] || dp[i - 1][j];
            }
            if (j > 0 && s2[j - 1] === s3[i + j - 1]) {
                dp[i][j] = dp[i][j] || dp[i][j - 1];
            }
        }
    }

    return dp[len1][len2];
};