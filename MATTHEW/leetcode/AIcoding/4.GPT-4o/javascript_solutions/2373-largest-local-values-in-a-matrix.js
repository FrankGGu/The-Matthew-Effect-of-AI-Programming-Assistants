var largestLocal = function(grid) {
    const n = grid.length;
    const result = new Array(n - 2).fill(0).map(() => new Array(n - 2).fill(0));

    for (let i = 0; i < n - 2; i++) {
        for (let j = 0; j < n - 2; j++) {
            let maxVal = 0;
            for (let x = 0; x < 3; x++) {
                for (let y = 0; y < 3; y++) {
                    maxVal = Math.max(maxVal, grid[i + x][j + y]);
                }
            }
            result[i][j] = maxVal;
        }
    }

    return result;
};