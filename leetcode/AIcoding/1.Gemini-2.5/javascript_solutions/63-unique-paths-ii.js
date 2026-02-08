var uniquePathsWithObstacles = function(obstacleGrid) {
    const m = obstacleGrid.length;
    const n = obstacleGrid[0].length;

    // If the starting cell has an obstacle, there are no paths.
    if (obstacleGrid[0][0] === 1) {
        return 0;
    }

    // Create a DP table to store the number of unique paths to each cell.
    // Initialize with zeros.
    const dp = Array(m).fill(0).map(() => Array(n).fill(0));

    // Base case: The starting cell has 1 way to reach itself (if no obstacle).
    dp[0][0] = 1;

    // Fill the first column
    for (let i = 1; i < m; i++) {
        // If the current cell is not an obstacle AND the cell directly above it is reachable,
        // then there is 1 way to reach this cell from the top.
        if (obstacleGrid[i][0] === 0 && dp[i - 1][0] === 1) {
            dp[i][0] = 1;
        }
    }

    // Fill the first row
    for (let j = 1; j < n; j++) {
        // If the current cell is not an obstacle AND the cell directly to its left is reachable,
        // then there is 1 way to reach this cell from the left.
        if (obstacleGrid[0][j] === 0 && dp[0][j - 1] === 1) {
            dp[0][j] = 1;
        }
    }

    // Fill the rest of the DP table
    for (let i = 1; i < m; i++) {
        for (let j = 1; j < n; j++) {
            if (obstacleGrid[i][j] === 1) {
                // If there's an obstacle, no paths can go through this cell.
                dp[i][j] = 0;
            } else {
                // The number of paths to the current cell is the sum of paths
                // from the cell above and the cell to the left.
                dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
            }
        }
    }

    // The result is the number of unique paths to the bottom-right corner.
    return dp[m - 1][n - 1];
};