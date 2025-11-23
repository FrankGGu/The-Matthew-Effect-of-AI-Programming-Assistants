var isMatch = function(s, p) {
    const sLen = s.length;
    const pLen = p.length;

    const dp = Array(sLen + 1).fill(false).map(() => Array(pLen + 1).fill(false));

    dp[0][0] = true;

    for (let j = 1; j <= pLen; j++) {
        if (p[j - 1] === '*') {
            dp[0][j] = dp[0][j - 1];
        }
    }

    for (let i = 1; i <= sLen; i++) {
        for (let j = 1; j <= pLen; j++) {
            if (p[j - 1] === '?' || s[i - 1] === p[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1];
            } else if (p[j - 1] === '*') {
                dp[i][j] = dp[i][j - 1] || dp[i - 1][j];
            }
        }
    }

    return dp[sLen][pLen];
};