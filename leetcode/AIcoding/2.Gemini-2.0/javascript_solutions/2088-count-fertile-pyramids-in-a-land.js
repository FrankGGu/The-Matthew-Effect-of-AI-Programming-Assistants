var countFertilePyramids = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let dp = Array(m).fill(null).map(() => Array(n).fill(0));
    let count = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                if (i === 0) {
                    dp[i][j] = 1;
                } else if (j === 0 || j === n - 1) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = Math.min(dp[i - 1][j - 1], dp[i - 1][j], dp[i - 1][j + 1]) + 1;
                }
                count += dp[i][j] -1 > 0? dp[i][j] -1 : 0;
            }
        }
    }

    dp = Array(m).fill(null).map(() => Array(n).fill(0));
    for (let i = m - 1; i >= 0; i--) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                if (i === m - 1) {
                    dp[i][j] = 1;
                } else if (j === 0 || j === n - 1) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = Math.min(dp[i + 1][j - 1], dp[i + 1][j], dp[i + 1][j + 1]) + 1;
                }
                count += dp[i][j] -1 > 0? dp[i][j] -1 : 0;
            }
        }
    }

    return count;
};