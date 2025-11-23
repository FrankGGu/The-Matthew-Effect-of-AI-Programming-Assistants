var equalSumGridPartitionII = function(grid) {
    const m = grid.length;
    if (m === 0) return false;
    const n = grid[0].length;
    if (n === 0) return false;

    if (m < 2 || n < 2) {
        return false;
    }

    const ps = Array(m + 1).fill(0).map(() => Array(n + 1).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            ps[i + 1][j + 1] = grid[i][j] + ps[i][j + 1] + ps[i + 1][j] - ps[i][j];
        }
    }

    const getSum = (r1, c1, r2, c2) => {
        return ps[r2 + 1][c2 + 1] - ps[r1][c2 + 1] - ps[r2 + 1][c1] + ps[r1][c1];
    };

    for (let r = 1; r < m; r++) {
        for (let c = 1; c < n; c++) {
            const sum1 = getSum(0, 0, r - 1, c - 1);
            const sum2 = getSum(0, c, r - 1, n - 1);
            const sum3 = getSum(r, 0, m - 1, c - 1);
            const sum4 = getSum(r, c, m - 1, n - 1);

            if (sum1 === sum2 && sum2 === sum3 && sum3 === sum4) {
                return true;
            }
        }
    }

    return false;
};