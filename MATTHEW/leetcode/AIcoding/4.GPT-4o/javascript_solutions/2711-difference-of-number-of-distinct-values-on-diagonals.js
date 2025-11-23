function differenceOfDistinctValues(grid) {
    const m = grid.length, n = grid[0].length;
    let result = Array.from({ length: m }, () => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const leftDiagonal = new Set();
            const rightDiagonal = new Set();

            for (let k = 0; k < m; k++) {
                if (i + k < m && j + k < n) leftDiagonal.add(grid[i + k][j + k]);
                if (i - k >= 0 && j + k < n) rightDiagonal.add(grid[i - k][j + k]);
            }

            result[i][j] = Math.abs(leftDiagonal.size - rightDiagonal.size);
        }
    }

    return result;
}