var surfaceArea = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let area = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] > 0) {
                area += 2;
                if (i > 0) area += Math.max(0, grid[i][j] - grid[i-1][j]);
                else area += grid[i][j];
                if (i < m - 1) area += Math.max(0, grid[i][j] - grid[i+1][j]);
                else area += grid[i][j];
                if (j > 0) area += Math.max(0, grid[i][j] - grid[i][j-1]);
                else area += grid[i][j];
                if (j < n - 1) area += Math.max(0, grid[i][j] - grid[i][j+1]);
                else area += grid[i][j];
            }
        }
    }
    return area;
};