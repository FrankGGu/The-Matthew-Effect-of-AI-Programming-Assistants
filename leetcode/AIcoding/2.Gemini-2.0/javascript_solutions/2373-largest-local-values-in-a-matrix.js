var largestLocal = function(grid) {
    const n = grid.length;
    const result = Array(n - 2).fill(null).map(() => Array(n - 2).fill(0));

    for (let i = 0; i < n - 2; i++) {
        for (let j = 0; j < n - 2; j++) {
            let maxVal = 0;
            for (let x = i; x < i + 3; x++) {
                for (let y = j; y < j + 3; y++) {
                    maxVal = Math.max(maxVal, grid[x][y]);
                }
            }
            result[i][j] = maxVal;
        }
    }

    return result;
};