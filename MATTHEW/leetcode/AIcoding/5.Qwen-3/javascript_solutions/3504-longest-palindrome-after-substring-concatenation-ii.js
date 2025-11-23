function longestPalindrome(s) {
    const n = s.length;
    const dp = new Array(n).fill(0).map(() => new Array(n).fill(0));
    let maxLen = 0;

    for (let i = 0; i < n; i++) {
        dp[i][i] = 1;
        maxLen = Math.max(maxLen, 1);
    }

    for (let length = 2; length <= n; length++) {
        for (let i = 0; i <= n - length; i++) {
            let j = i + length - 1;
            if (s[i] === s[j]) {
                if (length === 2) {
                    dp[i][j] = 2;
                } else {
                    dp[i][j] = dp[i + 1][j - 1] + 2;
                }
                maxLen = Math.max(maxLen, dp[i][j]);
            } else {
                dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
            }
        }
    }

    return maxLen;
}