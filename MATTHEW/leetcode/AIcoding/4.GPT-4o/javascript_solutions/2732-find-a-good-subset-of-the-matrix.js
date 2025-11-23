function goodSubset(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;

    const dp = new Array(m + 1).fill(0).map(() => new Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
            if (matrix[i - 1][j - 1] === 1) {
                dp[i][j] += 1;
            }
        }
    }

    return dp[m][n];
}