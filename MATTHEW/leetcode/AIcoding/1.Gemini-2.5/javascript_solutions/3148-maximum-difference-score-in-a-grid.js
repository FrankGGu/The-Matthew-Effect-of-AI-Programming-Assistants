var maxScore = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    // dp[i][j] will store the minimum value encountered in the subgrid grid[0...i][0...j]
    const dp = Array(m).fill(0).map(() => Array(n).fill(0));

    // Initialize maxScore to a very small number, as scores can be negative
    let maxScore = -Infinity;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const currentVal = grid[i][j];

            // Calculate the minimum value in the rectangle from (0,0) to (i,j)
            let minValInPrefix = currentVal;
            if (i > 0) {
                minValInPrefix = Math.min(minValInPrefix, dp[i - 1][j]);
            }
            if (j > 0) {
                minValInPrefix = Math.min(minValInPrefix, dp[i][j - 1]);
            }
            dp[i][j] = minValInPrefix;

            // Calculate the score for the current cell (i,j)
            // We need the minimum value from any cell (r1, c1) such that r1 <= i, c1 <= j, and (r1, c1) != (i,j)
            // This minimum value is found by considering the minimums from the cells above (i-1,j) and to the left (i,j-1).
            if (i > 0 || j > 0) { // Only calculate score if there's a previous cell
                let minValForScore = Infinity;
                if (i > 0) {
                    minValForScore = Math.min(minValForScore, dp[i - 1][j]);
                }
                if (j > 0) {
                    minValForScore = Math.min(minValForScore, dp[i][j - 1]);
                }
                maxScore = Math.max(maxScore, currentVal - minValForScore);
            }
        }
    }

    return maxScore;
};