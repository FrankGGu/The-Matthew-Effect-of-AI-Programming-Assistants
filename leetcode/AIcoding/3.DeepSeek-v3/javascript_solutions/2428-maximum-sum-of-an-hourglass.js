var maxSum = function(grid) {
    let max = 0;
    const rows = grid.length;
    const cols = grid[0].length;

    for (let i = 0; i < rows - 2; i++) {
        for (let j = 0; j < cols - 2; j++) {
            const sum = grid[i][j] + grid[i][j+1] + grid[i][j+2] 
                      + grid[i+1][j+1] 
                      + grid[i+2][j] + grid[i+2][j+1] + grid[i+2][j+2];
            if (sum > max || (i === 0 && j === 0)) {
                max = sum;
            }
        }
    }

    return max;
};