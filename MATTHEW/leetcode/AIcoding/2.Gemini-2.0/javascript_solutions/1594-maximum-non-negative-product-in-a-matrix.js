var maxProductPath = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const maxDP = Array(m).fill(null).map(() => Array(n).fill(0));
    const minDP = Array(m).fill(null).map(() => Array(n).fill(0));

    maxDP[0][0] = grid[0][0];
    minDP[0][0] = grid[0][0];

    for (let i = 1; i < m; i++) {
        maxDP[i][0] = maxDP[i - 1][0] * grid[i][0];
        minDP[i][0] = minDP[i - 1][0] * grid[i][0];
    }

    for (let j = 1; j < n; j++) {
        maxDP[0][j] = maxDP[0][j - 1] * grid[0][j];
        minDP[0][j] = minDP[0][j - 1] * grid[0][j];
    }

    for (let i = 1; i < m; i++) {
        for (let j = 1; j < n; j++) {
            const options = [
                maxDP[i - 1][j] * grid[i][j],
                minDP[i - 1][j] * grid[i][j],
                maxDP[i][j - 1] * grid[i][j],
                minDP[i][j - 1] * grid[i][j]
            ];
            maxDP[i][j] = Math.max(...options);
            minDP[i][j] = Math.min(...options);
        }
    }

    const result = maxDP[m - 1][n - 1];
    if (result < 0) {
        return -1;
    } else {
        return result % (10**9 + 7);
    }
};