var maxSubsequence = function(s, k, special) {
    const n = s.length;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(-Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            if (dp[i - 1][j] > dp[i][j]) {
                dp[i][j] = dp[i - 1][j];
            }
            if (j > 0) {
                for (let l = 1; l <= i; l++) {
                    const substr = s.substring(i - l, i);
                    if (special.includes(substr)) {
                        if (dp[i - l][j - 1] + substr.length > dp[i][j]) {
                            dp[i][j] = dp[i - l][j - 1] + substr.length;
                        }
                    }
                }
            }
        }
    }

    return dp[n][k] >= 0 ? dp[n][k] : 0;
};