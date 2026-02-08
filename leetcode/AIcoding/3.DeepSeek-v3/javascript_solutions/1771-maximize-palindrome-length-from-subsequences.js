var longestPalindrome = function(word1, word2) {
    const s = word1 + word2;
    const n = s.length;
    const m = word1.length;
    let dp = Array.from({ length: n }, () => new Array(n).fill(0));
    let max = 0;

    for (let i = n - 1; i >= 0; i--) {
        dp[i][i] = 1;
        for (let j = i + 1; j < n; j++) {
            if (s[i] === s[j]) {
                dp[i][j] = dp[i + 1][j - 1] + 2;
                if (i < m && j >= m) {
                    max = Math.max(max, dp[i][j]);
                }
            } else {
                dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
            }
        }
    }

    return max;
};