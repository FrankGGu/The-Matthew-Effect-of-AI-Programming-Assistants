var longestPalindrome = function(word1, word2) {
    const s = word1 + word2;
    const n = s.length;
    const n1 = word1.length;
    let dp = Array(n).fill(null).map(() => Array(n).fill(0));
    let ans = 0;

    for (let i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            let j = i + len - 1;
            if (s[i] === s[j]) {
                dp[i][j] = 2 + (i + 1 <= j - 1 ? dp[i + 1][j - 1] : 0);
                if (i < n1 && j >= n1) {
                    ans = Math.max(ans, dp[i][j]);
                }
            } else {
                dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
            }
        }
    }

    return ans;
};