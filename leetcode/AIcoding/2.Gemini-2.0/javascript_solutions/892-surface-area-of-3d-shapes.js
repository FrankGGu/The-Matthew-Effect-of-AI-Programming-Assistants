var surfaceArea = function(grid) {
    let area = 0;
    const n = grid.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] > 0) {
                area += 2;
                area += grid[i][j] * 4;
            }
            if (i > 0) {
                area -= Math.min(grid[i][j], grid[i - 1][j]);
            area -= Math.min(grid[i][j], grid[i - 1][j]);
            }
            if (j > 0) {
                area -= Math.min(grid[i][j], grid[i][j - 1]);
                area -= Math.min(grid[i][j], grid[i][j - 1]);
            }
        }
    }
    return area;
};