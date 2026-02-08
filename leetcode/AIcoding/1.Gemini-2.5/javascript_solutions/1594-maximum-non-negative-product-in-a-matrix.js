var maxProductPath = function(grid) {
    const MOD = 1000000007n;
    const m = grid.length;
    const n = grid[0].length;

    const dpMax = Array(m).fill(0).map(() => Array(n).fill(0n));
    const dpMin = Array(m).fill(0).map(() => Array(n).fill(0n));

    const max = (...args) => args.reduce((mVal, e) => (e > mVal ? e : mVal));
    const min = (...args) => args.reduce((mVal, e) => (e < mVal ? e : mVal));

    dpMax[0][0] = BigInt(grid[0][0]);
    dpMin[0][0] = BigInt(grid[0][0]);

    for (let j = 1; j < n; j++) {
        dpMax[0][j] = dpMax[0][j - 1] * BigInt(grid[0][j]);
        dpMin[0][j] = dpMin[0][j - 1] * BigInt(grid[0][j]);
    }

    for (let i = 1; i < m; i++) {
        dpMax[i][0] = dpMax[i - 1][0] * BigInt(grid[i][0]);
        dpMin[i][0] = dpMin[i - 1][0] * BigInt(grid[i][0]);
    }

    for (let i = 1; i < m; i++) {
        for (let j = 1; j < n; j++) {
            const val = BigInt(grid[i][j]);

            const p1 = dpMax[i - 1][j] * val;
            const p2 = dpMin[i - 1][j] * val;
            const p3 = dpMax[i][j - 1] * val;
            const p4 = dpMin[i][j - 1] * val;

            dpMax[i][j] = max(p1, p2, p3, p4);
            dpMin[i][j] = min(p1, p2, p3, p4);
        }
    }

    const result = dpMax[m - 1][n - 1];

    if (result < 0n) {
        return -1;
    } else {
        return Number(result % MOD);
    }
};