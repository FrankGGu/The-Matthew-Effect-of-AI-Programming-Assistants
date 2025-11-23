function checkValidString(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const dp = new Array(m).fill(0).map(() => new Array(n).fill(0).map(() => new Array(2).fill(false)));

    if (grid[0][0] === '(') {
        dp[0][0][0] = true;
    } else if (grid[0][0] === ')') {
        dp[0][0][1] = true;
    } else {
        dp[0][0][0] = true;
        dp[0][0][1] = true;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 && j === 0) continue;
            const cell = grid[i][j];
            if (cell === '(') {
                if (i > 0) {
                    dp[i][j][0] = dp[i-1][j][0];
                }
                if (j > 0) {
                    dp[i][j][0] = dp[i][j][0] || dp[i][j-1][0];
                }
            } else if (cell === ')') {
                if (i > 0) {
                    dp[i][j][1] = dp[i-1][j][1];
                }
                if (j > 0) {
                    dp[i][j][1] = dp[i][j][1] || dp[i][j-1][1];
                }
            } else {
                if (i > 0) {
                    dp[i][j][0] = dp[i-1][j][0];
                    dp[i][j][1] = dp[i-1][j][1];
                }
                if (j > 0) {
                    dp[i][j][0] = dp[i][j][0] || dp[i][j-1][0];
                    dp[i][j][1] = dp[i][j][1] || dp[i][j-1][1];
                }
            }
        }
    }

    return dp[m-1][n-1][0];
}