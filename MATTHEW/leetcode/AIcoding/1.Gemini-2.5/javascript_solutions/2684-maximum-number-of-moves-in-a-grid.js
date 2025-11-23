var maxMoves = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const dp = Array(m).fill(0).map(() => Array(n).fill(-1));

    let maxMovesCount = 0;

    for (let r = 0; r < m; r++) {
        dp[r][0] = 0;
    }

    for (let c = 0; c < n - 1; c++) {
        for (let r = 0; r < m; r++) {
            if (dp[r][c] !== -1) {
                const currentVal = grid[r][c];

                if (r - 1 >= 0 && grid[r - 1][c + 1] > currentVal) {
                    dp[r - 1][c + 1] = Math.max(dp[r - 1][c + 1], dp[r][c] + 1);
                    maxMovesCount = Math.max(maxMovesCount, dp[r - 1][c + 1]);
                }

                if (grid[r][c + 1] > currentVal) {
                    dp[r][c + 1] = Math.max(dp[r][c + 1], dp[r][c] + 1);
                    maxMovesCount = Math.max(maxMovesCount, dp[r][c + 1]);
                }

                if (r + 1 < m && grid[r + 1][c + 1] > currentVal) {
                    dp[r + 1][c + 1] = Math.max(dp[r + 1][c + 1], dp[r][c] + 1);
                    maxMovesCount = Math.max(maxMovesCount, dp[r + 1][c + 1]);
                }
            }
        }
    }

    return maxMovesCount;
};