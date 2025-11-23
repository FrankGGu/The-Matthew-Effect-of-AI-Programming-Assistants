var projectionArea = function(grid) {
    let n = grid.length;
    let xyArea = 0;
    let xzArea = 0;
    let yzArea = 0;

    for (let i = 0; i < n; i++) {
        let xzMax = 0;
        let yzMax = 0;
        for (let j = 0; j < n; j++) {
            if (grid[i][j] > 0) {
                xyArea++;
            }
            xzMax = Math.max(xzMax, grid[i][j]);
            yzMax = Math.max(yzMax, grid[j][i]);
        }
        xzArea += xzMax;
        yzArea += yzMax;
    }

    return xyArea + xzArea + yzArea;
};