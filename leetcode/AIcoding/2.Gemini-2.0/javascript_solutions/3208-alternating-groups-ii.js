var maxAlternatingSubsequenceLength = function(s) {
    let n = s.length;
    let dp = new Array(n).fill(0);
    dp[0] = 1;

    for (let i = 1; i < n; i++) {
        dp[i] = 1;
        for (let j = 0; j < i; j++) {
            if (s[i] !== s[j] && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
            }
        }
    }

    let maxLen = 0;
    for (let i = 0; i < n; i++) {
        maxLen = Math.max(maxLen, dp[i]);
    }

    return maxLen;
};