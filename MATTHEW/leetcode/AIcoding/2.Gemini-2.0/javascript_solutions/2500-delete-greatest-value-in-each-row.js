var deleteGreatestValue = function(grid) {
    let sum = 0;
    for (let i = 0; i < grid.length; i++) {
        grid[i].sort((a, b) => a - b);
    }

    for (let j = 0; j < grid[0].length; j++) {
        let max = 0;
        for (let i = 0; i < grid.length; i++) {
            max = Math.max(max, grid[i][j]);
        }
        sum += max;
    }

    return sum;
};