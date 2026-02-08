var maxSum = function(grid) {
    let m = grid.length;
    let n = grid[0].length;
    let maxHourglassSum = 0;

    for (let i = 0; i <= m - 3; i++) {
        for (let j = 0; j <= n - 3; j++) {
            let currentHourglassSum = 0;

            currentHourglassSum += grid[i][j];
            currentHourglassSum += grid[i][j + 1];
            currentHourglassSum += grid[i][j + 2];

            currentHourglassSum += grid[i + 1][j + 1];

            currentHourglassSum += grid[i + 2][j];
            currentHourglassSum += grid[i + 2][j + 1];
            currentHourglassSum += grid[i + 2][j + 2];

            if (currentHourglassSum > maxHourglassSum) {
                maxHourglassSum = currentHourglassSum;
            }
        }
    }

    return maxHourglassSum;
};