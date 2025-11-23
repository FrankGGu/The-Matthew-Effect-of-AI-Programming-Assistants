var maxMoves = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = new Array(m).fill().map(() => new Array(n).fill(0));
    let maxMoves = 0;

    for (let j = n - 2; j >= 0; j--) {
        for (let i = 0; i < m; i++) {
            let max = 0;
            for (const [di, dj] of [[-1, 1], [0, 1], [1, 1]]) {
                const ni = i + di;
                const nj = j + dj;
                if (ni >= 0 && ni < m && nj < n && grid[i][j] < grid[ni][nj]) {
                    max = Math.max(max, 1 + dp[ni][nj]);
                }
            }
            dp[i][j] = max;
            if (j === 0) {
                maxMoves = Math.max(maxMoves, dp[i][j]);
            }
        }
    }

    return maxMoves;
};