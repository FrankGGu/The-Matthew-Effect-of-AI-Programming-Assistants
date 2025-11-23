var projectionArea = function(grid) {
    let area = 0;
    for (let i = 0; i < grid.length; i++) {
        let maxRow = 0;
        for (let j = 0; j < grid[i].length; j++) {
            if (grid[i][j] > 0) {
                area++;
            }
            maxRow = Math.max(maxRow, grid[i][j]);
        }
        area += maxRow;
    }
    return area;
};