var projectionArea = function(grid) {
    let xy = 0, xz = 0, yz = 0;
    let m = grid.length, n = grid[0].length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] > 0) xy++;
            xz = Math.max(xz, grid[i][j]);
            yz = Math.max(yz, grid[j][i]);
        }
    }

    return xy + (xz * m) + (yz * n);
};