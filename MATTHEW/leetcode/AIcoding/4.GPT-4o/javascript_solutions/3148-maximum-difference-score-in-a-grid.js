var maximumDifference = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    let maxDiff = -1;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            for (let x = i; x < rows; x++) {
                for (let y = j; y < cols; y++) {
                    if (grid[i][j] < grid[x][y]) {
                        maxDiff = Math.max(maxDiff, grid[x][y] - grid[i][j]);
                    }
                }
            }
        }
    }

    return maxDiff;
};