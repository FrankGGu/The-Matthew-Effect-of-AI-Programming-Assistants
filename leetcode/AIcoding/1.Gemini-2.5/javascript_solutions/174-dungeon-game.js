var calculateMinimumHP = function(dungeon) {
    const m = dungeon.length;
    const n = dungeon[0].length;

    // dp[i][j] represents the minimum health the knight needs to have
    // upon entering cell (i, j) to successfully reach the princess.
    const dp = Array(m).fill(0).map(() => Array(n).fill(0));

    // Base case: destination cell (m-1, n-1)
    // The knight needs to have at least 1 health after passing through this cell.
    // Let H be the health upon entering (m-1, n-1).
    // H + dungeon[m-1][n-1] >= 1
    // H >= 1 - dungeon[m-1][n-1]
    // Also, H must be at least 1 (the knight must be alive upon entering).
    dp[m - 1][n - 1] = Math.max(1, 1 - dungeon[m - 1][n - 1]);

    // Fill the last row (moving from right to left)
    for (let j = n - 2; j >= 0; j--) {
        // From (m-1, j), the only possible move is to (m-1, j+1).
        // Health upon entering (m-1, j) is H. After dungeon[m-1][j], health becomes H + dungeon[m-1][j].
        // This health must be sufficient for the next step, i.e., >= dp[m-1][j+1].
        // H + dungeon[m-1][j] >= dp[m-1][j+1]
        // H >= dp[m-1][j+1] - dungeon[m-1][j]
        // Also, H must be at least 1.
        dp[m - 1][j] = Math.max(1, dp[m - 1][j + 1] - dungeon[m - 1][j]);
    }

    // Fill the last column (moving from bottom to top)
    for (let i = m - 2; i >= 0; i--) {
        // From (i, n-1), the only possible move is to (i+1, n-1).
        // Similar logic as above.
        dp[i][n - 1] = Math.max(1, dp[i + 1][n - 1] - dungeon[i][n - 1]);
    }

    // Fill the rest of the DP table (moving from bottom-right to top-left)
    for (let i = m - 2; i >= 0; i--) {
        for (let j = n - 2; j >= 0; j--) {
            // From (i, j), the knight can move to (i+1, j) or (i, j+1).
            // The knight will choose the path that requires less health for the next step.
            const nextMinHealth = Math.min(dp[i + 1][j], dp[i][j + 1]);

            // Health upon entering (i, j) is H. After dungeon[i][j], health becomes H + dungeon[i][j].
            // This health must be sufficient for the chosen next step, i.e., >= nextMinHealth.
            // H + dungeon[i][j] >= nextMinHealth
            // H >= nextMinHealth - dungeon[i][j]
            // Also, H must be at least 1.
            dp[i][j] = Math.max(1, nextMinHealth - dungeon[i][j]);
        }
    }

    // The result is the minimum health required upon entering the starting cell (0, 0).
    return dp[0][0];
};