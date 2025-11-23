var projectionArea = function(grid) {
    let xy = 0, yz = 0, xz = 0;
    const n = grid.length;

    for (let i = 0; i < n; i++) {
        let maxRow = 0;
        let maxCol = 0;
        for (let j = 0; j < n; j++) {
            if (grid[i][j] > 0) xy++;
            maxRow = Math.max(maxRow, grid[i][j]);
            maxCol = Math.max(maxCol, grid[j][i]);
        }
        yz += maxRow;
        xz += maxCol;
    }

    return xy + yz + xz;
};