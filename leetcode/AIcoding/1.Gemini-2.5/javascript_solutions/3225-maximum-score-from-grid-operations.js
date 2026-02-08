var maximumScore = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const dp = Array(m).fill(0).map(() => Array(n).fill(0));

    let totalScore = 0;

    dp[0][0] = Math.max(0, grid[0][0] - 1);
    totalScore += dp[0][0];

    for (let c = 1; c < n; c++) {
        const requiredVal = dp[0][c - 1] + 1;

        if (requiredVal < grid[0][c]) {
            dp[0][c] = requiredVal;
        }
        totalScore += dp[0][c];
    }

    for (let r = 1; r < m; r++) {
        const requiredVal = dp[r - 1][0] + 1;

        if (requiredVal < grid[r][0]) {
            dp[r][0] = requiredVal;
        }
        totalScore += dp[r][0];
    }

    for (let r = 1; r < m; r++) {
        for (let c = 1; c < n; c++) {
            const requiredVal = Math.max(dp[r - 1][c], dp[r][c - 1]) + 1;

            if (requiredVal < grid[r][c]) {
                dp[r][c] = requiredVal;
            }
            totalScore += dp[r][c];
        }
    }

    return totalScore;
};