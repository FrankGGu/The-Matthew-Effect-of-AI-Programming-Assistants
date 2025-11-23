var surfaceArea = function(grid) {
    let totalArea = 0;
    let overlap = 0;

    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[0].length; j++) {
            if (grid[i][j] > 0) {
                totalArea += grid[i][j] * 4 + 2;
                if (i > 0) overlap += Math.min(grid[i][j], grid[i - 1][j]);
                if (j > 0) overlap += Math.min(grid[i][j], grid[i][j - 1]);
            }
        }
    }

    return totalArea - overlap;
};