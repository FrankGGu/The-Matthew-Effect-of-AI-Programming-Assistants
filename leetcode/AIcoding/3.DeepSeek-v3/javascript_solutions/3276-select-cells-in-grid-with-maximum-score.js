var maxScore = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = new Array(m).fill().map(() => new Array(n).fill(-Infinity));
    let maxScore = -Infinity;

    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            let currentMax = -Infinity;
            if (i + 1 < m) {
                currentMax = Math.max(currentMax, grid[i + 1][j] - grid[i][j] + dp[i + 1][j]);
            }
            if (j + 1 < n) {
                currentMax = Math.max(currentMax, grid[i][j + 1] - grid[i][j] + dp[i][j + 1]);
            }
            dp[i][j] = currentMax === -Infinity ? 0 : currentMax;
            maxScore = Math.max(maxScore, dp[i][j]);
        }
    }

    return maxScore;
};