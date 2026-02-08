var sandPile = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    while (true) {
        let unstable = false;
        let nextGrid = Array(m).fill(null).map(() => Array(n).fill(0));

        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (grid[i][j] >= 4) {
                    unstable = true;
                    nextGrid[i][j] += grid[i][j] - 4;

                    if (i > 0) nextGrid[i - 1][j]++;
                    if (i < m - 1) nextGrid[i + 1][j]++;
                    if (j > 0) nextGrid[i][j - 1]++;
                    if (j < n - 1) nextGrid[i][j + 1]++;
                } else {
                    nextGrid[i][j] += grid[i][j];
                }
            }
        }

        if (!unstable) {
            return grid;
        }

        grid = nextGrid;
    }
};