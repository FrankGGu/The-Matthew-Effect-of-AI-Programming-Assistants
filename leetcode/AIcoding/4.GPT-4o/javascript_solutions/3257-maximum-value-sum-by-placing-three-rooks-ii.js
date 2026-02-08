var maxValue = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    let maxSum = 0;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            for (let k = i + 1; k < rows; k++) {
                for (let l = j + 1; l < cols; l++) {
                    for (let m = k + 1; m < rows; m++) {
                        for (let n = l + 1; n < cols; n++) {
                            const sum = grid[i][j] + grid[k][l] + grid[m][n];
                            maxSum = Math.max(maxSum, sum);
                        }
                    }
                }
            }
        }
    }

    return maxSum;
};