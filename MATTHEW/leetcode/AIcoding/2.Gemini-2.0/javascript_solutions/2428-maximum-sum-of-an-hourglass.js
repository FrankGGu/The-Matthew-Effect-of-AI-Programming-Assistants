var maxSum = function(grid) {
    let rows = grid.length;
    let cols = grid[0].length;
    let maxSum = -Infinity;

    for (let i = 0; i <= rows - 3; i++) {
        for (let j = 0; j <= cols - 3; j++) {
            let currentSum = grid[i][j] + grid[i][j + 1] + grid[i][j + 2] +
                              grid[i + 1][j + 1] +
                              grid[i + 2][j] + grid[i + 2][j + 1] + grid[i + 2][j + 2];
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
};