function minOperations(grid) {
    let operations = 0;
    for (let j = 0; j < grid[0].length; j++) {
        for (let i = 1; i < grid.length; i++) {
            if (grid[i][j] <= grid[i - 1][j]) {
                operations += grid[i - 1][j] - grid[i][j] + 1;
                grid[i][j] += grid[i - 1][j] - grid[i][j] + 1;
            }
        }
    }
    return operations;
}