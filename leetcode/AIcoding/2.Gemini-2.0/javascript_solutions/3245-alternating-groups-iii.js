var maxAlternatingSubsequence = function(s) {
    let n = s.length;
    let dp = new Array(n).fill(1);

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if ((s[i] - '0') % 2 !== (s[j] - '0') % 2) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
            }
        }
    }

    let maxLen = 0;
    for (let i = 0; i < n; i++) {
        maxLen = Math.max(maxLen, dp[i]);
    }

    return maxLen;
};