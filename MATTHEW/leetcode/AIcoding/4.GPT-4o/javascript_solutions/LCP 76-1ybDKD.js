function magicalChessboard(A) {
    const n = A.length;
    const dp = Array.from({ length: n + 1 }, () => Array(n + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (A[i][j] === 1) continue;
            dp[i + 1][j + 1] = (dp[i + 1][j + 1] + dp[i][j]) % (1e9 + 7);
            dp[i + 1][j] = (dp[i + 1][j] + dp[i][j]) % (1e9 + 7);
            dp[i][j + 1] = (dp[i][j + 1] + dp[i][j]) % (1e9 + 7);
        }
    }
    return dp[n][n];
}