var findMaxFish = function(grid) {
    let rows = grid.length;
    let cols = grid[0].length;
    let maxFish = 0;

    function dfs(row, col) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] === 0) {
            return 0;
        }

        let fish = grid[row][col];
        grid[row][col] = 0;

        fish += dfs(row + 1, col);
        fish += dfs(row - 1, col);
        fish += dfs(row, col + 1);
        fish += dfs(row, col - 1);

        return fish;
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] > 0) {
                maxFish = Math.max(maxFish, dfs(i, j));
            }
        }
    }

    return maxFish;
};