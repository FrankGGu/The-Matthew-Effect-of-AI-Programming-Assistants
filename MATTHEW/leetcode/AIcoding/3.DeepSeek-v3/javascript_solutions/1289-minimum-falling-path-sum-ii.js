var minFallingPathSum = function(grid) {
    const n = grid.length;
    if (n === 1) return grid[0][0];

    for (let i = 1; i < n; i++) {
        let firstMin = Infinity, secondMin = Infinity;
        let firstMinIndex = -1;

        for (let j = 0; j < n; j++) {
            if (grid[i-1][j] < firstMin) {
                secondMin = firstMin;
                firstMin = grid[i-1][j];
                firstMinIndex = j;
            } else if (grid[i-1][j] < secondMin) {
                secondMin = grid[i-1][j];
            }
        }

        for (let j = 0; j < n; j++) {
            if (j !== firstMinIndex) {
                grid[i][j] += firstMin;
            } else {
                grid[i][j] += secondMin;
            }
        }
    }

    return Math.min(...grid[n-1]);
};