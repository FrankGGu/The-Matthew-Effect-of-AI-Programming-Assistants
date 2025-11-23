var maxMoves = function(grid) {
    const m = grid.length, n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));

    for (let j = 0; j < n; j++) {
        dp[0][j] = 1;
    }

    for (let i = 1; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (j > 0 && grid[i][j] > grid[i - 1][j - 1]) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - 1] + 1);
            }
            if (grid[i][j] > grid[i - 1][j]) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j] + 1);
            }
            if (j < n - 1 && grid[i][j] > grid[i - 1][j + 1]) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j + 1] + 1);
            }
        }
    }

    return Math.max(...dp[m - 1]);
};