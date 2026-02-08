var projectionArea = function(grid) {
    let n = grid.length;
    let xyArea = 0;
    let yzArea = 0; // Sum of maxes in each row
    let xzArea = 0; // Sum of maxes in each column

    let colMaxes = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let rowMax = 0;
        for (let j = 0; j < n; j++) {
            // XY-plane projection
            if (grid[i][j] > 0) {
                xyArea++;
            }

            // YZ-plane projection (max of current row)
            rowMax = Math.max(rowMax, grid[i][j]);

            // XZ-plane projection (max of current column)
            colMaxes[j] = Math.max(colMaxes[j], grid[i][j]);
        }
        yzArea += rowMax;
    }

    // Sum up the maximums for each column to get xzArea
    for (let j = 0; j < n; j++) {
        xzArea += colMaxes[j];
    }

    return xyArea + yzArea + xzArea;
};