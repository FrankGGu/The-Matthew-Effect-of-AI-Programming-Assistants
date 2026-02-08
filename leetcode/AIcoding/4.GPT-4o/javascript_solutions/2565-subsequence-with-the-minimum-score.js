var minimumScore = function(s, t) {
    const n = s.length, m = t.length;
    const dp = Array(n + 1).fill(0).map(() => Array(m + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 0; i <= n; i++) {
        for (let j = 0; j <= m; j++) {
            if (i < n) dp[i + 1][j] = Math.min(dp[i + 1][j], dp[i][j] + 1);
            if (j < m) dp[i][j + 1] = Math.min(dp[i][j + 1], dp[i][j] + 1);
            if (i < n && j < m && s[i] === t[j]) dp[i + 1][j + 1] = Math.min(dp[i + 1][j + 1], dp[i][j]);
        }
    }

    let minScore = Infinity;
    for (let j = 0; j <= m; j++) {
        minScore = Math.min(minScore, dp[n][j]);
    }

    return minScore === Infinity ? -1 : minScore;
};