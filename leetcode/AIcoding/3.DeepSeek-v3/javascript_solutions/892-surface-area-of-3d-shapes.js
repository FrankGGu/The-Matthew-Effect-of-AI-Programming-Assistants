var surfaceArea = function(grid) {
    let area = 0;
    const n = grid.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            const height = grid[i][j];
            if (height > 0) {
                area += 2;
                area += 4 * height;
                if (i > 0) area -= 2 * Math.min(height, grid[i - 1][j]);
                if (j > 0) area -= 2 * Math.min(height, grid[i][j - 1]);
            }
        }
    }
    return area;
};