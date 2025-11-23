var maxScore = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = new Array(m).fill().map(() => new Array(n).fill(-Infinity));
    let maxScore = -Infinity;

    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            let max = -Infinity;
            if (i + 1 < m) {
                max = Math.max(max, grid[i + 1][j] - grid[i][j] + dp[i + 1][j]);
            }
            if (j + 1 < n) {
                max = Math.max(max, grid[i][j + 1] - grid[i][j] + dp[i][j + 1]);
            }
            dp[i][j] = max === -Infinity ? 0 : max;
            if (i !== 0 || j !== 0) {
                maxScore = Math.max(maxScore, dp[i][j]);
            }
        }
    }

    return maxScore;
};