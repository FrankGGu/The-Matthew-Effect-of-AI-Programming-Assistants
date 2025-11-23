var equalSumGridPartitionI = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;

    if (rows < 2 || cols < 2) {
        return false;
    }

    const ps = Array(rows + 1).fill(0).map(() => Array(cols + 1).fill(0));
    let totalSum = 0;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            ps[i + 1][j + 1] = grid[i][j] + ps[i][j + 1] + ps[i + 1][j] - ps[i][j];
            totalSum += grid[i][j];
        }
    }

    const getSum = (r1, c1, r2, c2) => {
        return ps[r2 + 1][c2 + 1] - ps[r1][c2 + 1] - ps[r2 + 1][c1] + ps[r1][c1];
    };

    if (totalSum % 4 !== 0) {
        return false;
    }

    const targetSum = totalSum / 4;

    for (let r = 0; r < rows - 1; r++) {
        for (let c = 0; c < cols - 1; c++) {
            const sum1 = getSum(0, 0, r, c);
            const sum2 = getSum(0, c + 1, r, cols - 1);
            const sum3 = getSum(r + 1, 0, rows - 1, c);
            const sum4 = getSum(r + 1, c + 1, rows - 1, cols - 1);

            if (sum1 === targetSum && sum2 === targetSum && sum3 === targetSum && sum4 === targetSum) {
                return true;
            }
        }
    }

    return false;
};