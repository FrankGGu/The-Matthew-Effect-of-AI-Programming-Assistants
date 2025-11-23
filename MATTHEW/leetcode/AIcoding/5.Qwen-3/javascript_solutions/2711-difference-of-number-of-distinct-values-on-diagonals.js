function differenceOfDistinctValues(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const result = new Array(m).fill(0).map(() => new Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const diag1 = new Set();
            const diag2 = new Set();

            let x = i - 1, y = j - 1;
            while (x >= 0 && y >= 0) {
                diag1.add(grid[x][y]);
                x--;
                y--;
            }

            x = i + 1;
            y = j + 1;
            while (x < m && y < n) {
                diag1.add(grid[x][y]);
                x++;
                y++;
            }

            x = i - 1;
            y = j + 1;
            while (x >= 0 && y < n) {
                diag2.add(grid[x][y]);
                x--;
                y++;
            }

            x = i + 1;
            y = j - 1;
            while (x < m && y >= 0) {
                diag2.add(grid[x][y]);
                x++;
                y--;
            }

            result[i][j] = Math.abs(diag1.size - diag2.size);
        }
    }

    return result;
}