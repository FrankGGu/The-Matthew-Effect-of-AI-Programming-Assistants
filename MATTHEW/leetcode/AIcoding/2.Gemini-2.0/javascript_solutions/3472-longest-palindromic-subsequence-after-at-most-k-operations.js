var longestPalindromeSubsequence = function(s, k) {
    const n = s.length;
    const dp = Array(n).fill(null).map(() => Array(n).fill(Infinity));

    for (let i = 0; i < n; i++) {
        dp[i][i] = 0;
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            let j = i + len - 1;
            if (s[i] === s[j]) {
                dp[i][j] = dp[i + 1][j - 1];
            } else {
                dp[i][j] = Math.min(dp[i + 1][j], dp[i][j - 1]) + 1;
            }
        }
    }

    let changes = dp[0][n - 1];
    return changes <= k ? n : n - (changes - k);
};