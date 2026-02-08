var minExtraChar = function(s, dictionary) {
    const n = s.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + 1;
        for (const word of dictionary) {
            const len = word.length;
            if (i >= len && s.substring(i - len, i) === word) {
                dp[i] = Math.min(dp[i], dp[i - len]);
            }
        }
    }

    return dp[n];
};