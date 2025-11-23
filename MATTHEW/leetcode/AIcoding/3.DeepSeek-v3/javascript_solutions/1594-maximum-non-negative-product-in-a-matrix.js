var maxProductPath = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const MOD = 1e9 + 7;

    const dpMax = new Array(m).fill(0).map(() => new Array(n).fill(0));
    const dpMin = new Array(m).fill(0).map(() => new Array(n).fill(0));

    dpMax[0][0] = dpMin[0][0] = grid[0][0];

    for (let i = 1; i < m; i++) {
        const val = dpMax[i-1][0] * grid[i][0];
        dpMax[i][0] = val;
        dpMin[i][0] = val;
    }

    for (let j = 1; j < n; j++) {
        const val = dpMax[0][j-1] * grid[0][j];
        dpMax[0][j] = val;
        dpMin[0][j] = val;
    }

    for (let i = 1; i < m; i++) {
        for (let j = 1; j < n; j++) {
            const val = grid[i][j];
            const maxUp = dpMax[i-1][j] * val;
            const minUp = dpMin[i-1][j] * val;
            const maxLeft = dpMax[i][j-1] * val;
            const minLeft = dpMin[i][j-1] * val;

            dpMax[i][j] = Math.max(maxUp, minUp, maxLeft, minLeft);
            dpMin[i][j] = Math.min(maxUp, minUp, maxLeft, minLeft);
        }
    }

    const result = dpMax[m-1][n-1];
    return result >= 0 ? result % MOD : -1;
};