var onesMinusZeros = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const onesRow = new Array(m).fill(0);
    const onesCol = new Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                onesRow[i]++;
                onesCol[j]++;
            }
        }
    }

    const diff = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            diff[i][j] = 2 * onesRow[i] + 2 * onesCol[j] - n - m;
        }
    }

    return diff;
};