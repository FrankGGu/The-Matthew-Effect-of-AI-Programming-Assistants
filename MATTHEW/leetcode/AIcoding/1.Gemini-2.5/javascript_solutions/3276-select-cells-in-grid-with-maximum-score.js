var maxScore = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const dp = Array(m).fill(0).map(() => Array(n).fill(0));

    let maxScore = -Infinity;

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            let minValForR1C1 = Infinity;

            if (r > 0) {
                minValForR1C1 = Math.min(minValForR1C1, dp[r - 1][c]);
            }
            if (c > 0) {
                minValForR1C1 = Math.min(minValForR1C1, dp[r][c - 1]);
            }

            if (minValForR1C1 !== Infinity) {
                maxScore = Math.max(maxScore, grid[r][c] - minValForR1C1);
            }

            dp[r][c] = grid[r][c];
            if (r > 0) {
                dp[r][c] = Math.min(dp[r][c], dp[r - 1][c]);
            }
            if (c > 0) {
                dp[r][c] = Math.min(dp[r][c], dp[r][c - 1]);
            }
        }
    }

    return maxScore;
};