var maxScore = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = new Array(m).fill().map(() => new Array(n).fill(-Infinity));
    let maxDiff = -Infinity;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 && j === 0) {
                dp[i][j] = -Infinity;
                continue;
            }
            let minVal = Infinity;
            if (i > 0) {
                minVal = Math.min(minVal, grid[i-1][j]);
                minVal = Math.min(minVal, dp[i-1][j]);
            }
            if (j > 0) {
                minVal = Math.min(minVal, grid[i][j-1]);
                minVal = Math.min(minVal, dp[i][j-1]);
            }
            dp[i][j] = minVal;
            maxDiff = Math.max(maxDiff, grid[i][j] - minVal);
        }
    }

    return maxDiff;
};