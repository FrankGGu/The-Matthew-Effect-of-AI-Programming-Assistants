function gridGame(knight) {
    const n = knight.length;
    const m = knight[0].length;
    const dp = Array(n).fill(0).map(() => Array(m).fill(0));

    dp[0][0] = knight[0][0];

    for (let i = 1; i < n; i++) {
        dp[i][0] = dp[i - 1][0] + knight[i][0];
    }

    for (let j = 1; j < m; j++) {
        dp[0][j] = dp[0][j - 1] + knight[0][j];
    }

    for (let i = 1; i < n; i++) {
        for (let j = 1; j < m; j++) {
            dp[i][j] = Math.min(dp[i - 1][j], dp[i][j - 1]) + knight[i][j];
        }
    }

    return dp[n - 1][m - 1];
}