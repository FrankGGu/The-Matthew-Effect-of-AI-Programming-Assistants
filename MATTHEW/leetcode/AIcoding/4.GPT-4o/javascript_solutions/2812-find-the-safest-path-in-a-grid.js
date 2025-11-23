function safestPath(grid) {
    const m = grid.length, n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));

    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            if (i === m - 1 && j === n - 1) {
                dp[i][j] = grid[i][j];
            } else {
                let down = i + 1 < m ? dp[i + 1][j] : Infinity;
                let right = j + 1 < n ? dp[i][j + 1] : Infinity;
                dp[i][j] = Math.min(down, right) + grid[i][j];
            }
        }
    }

    return dp[0][0];
}