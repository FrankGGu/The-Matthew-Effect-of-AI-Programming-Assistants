var differenceOfDistinctValues = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const result = Array(m).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const topLeft = new Set();
            const bottomRight = new Set();

            let row = i - 1;
            let col = j - 1;
            while (row >= 0 && col >= 0) {
                topLeft.add(grid[row][col]);
                row--;
                col--;
            }

            row = i + 1;
            col = j + 1;
            while (row < m && col < n) {
                bottomRight.add(grid[row][col]);
                row++;
                col++;
            }

            result[i][j] = Math.abs(topLeft.size - bottomRight.size);
        }
    }

    return result;
};