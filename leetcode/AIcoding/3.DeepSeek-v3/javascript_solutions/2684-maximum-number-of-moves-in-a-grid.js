var maxMoves = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = new Array(m).fill().map(() => new Array(n).fill(0));
    let maxMoves = 0;

    for (let j = n - 2; j >= 0; j--) {
        for (let i = 0; i < m; i++) {
            const current = grid[i][j];
            let max = 0;

            if (i > 0 && grid[i - 1][j + 1] > current) {
                max = Math.max(max, dp[i - 1][j + 1] + 1);
            }
            if (grid[i][j + 1] > current) {
                max = Math.max(max, dp[i][j + 1] + 1);
            }
            if (i < m - 1 && grid[i + 1][j + 1] > current) {
                max = Math.max(max, dp[i + 1][j + 1] + 1);
            }

            dp[i][j] = max;
            if (j === 0) {
                maxMoves = Math.max(maxMoves, dp[i][j]);
            }
        }
    }

    return maxMoves;
};