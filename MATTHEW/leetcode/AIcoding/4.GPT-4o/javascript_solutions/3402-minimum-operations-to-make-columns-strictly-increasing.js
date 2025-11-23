function minOperations(grid) {
    const m = grid.length, n = grid[0].length;
    const dp = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let j = 0; j < n; j++) {
        dp[0][j] = grid[0][j];
    }

    for (let i = 1; i < m; i++) {
        for (let j = 0; j < n; j++) {
            dp[i][j] = dp[i - 1][j] + grid[i][j];
        }
    }

    let minOperations = Infinity;

    for (let j = 0; j < n; j++) {
        let operations = 0;
        let prev = -1;

        for (let i = 0; i < m; i++) {
            if (grid[i][j] <= prev) {
                operations += (prev + 1) - grid[i][j];
                grid[i][j] = prev + 1;
            }
            prev = grid[i][j];
        }

        minOperations = Math.min(minOperations, operations);
    }

    return minOperations;
}