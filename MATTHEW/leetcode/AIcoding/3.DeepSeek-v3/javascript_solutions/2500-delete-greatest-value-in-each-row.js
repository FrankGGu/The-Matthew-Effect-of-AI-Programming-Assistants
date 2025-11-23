var deleteGreatestValue = function(grid) {
    let sum = 0;
    for (let i = 0; i < grid.length; i++) {
        grid[i].sort((a, b) => a - b);
    }
    while (grid[0].length > 0) {
        let max = -Infinity;
        for (let i = 0; i < grid.length; i++) {
            const val = grid[i].pop();
            if (val > max) {
                max = val;
            }
        }
        sum += max;
    }
    return sum;
};