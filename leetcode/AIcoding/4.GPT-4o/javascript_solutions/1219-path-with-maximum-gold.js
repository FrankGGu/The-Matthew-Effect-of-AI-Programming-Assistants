var getMaximumGold = function(grid) {
    let maxGold = 0;
    const rows = grid.length;
    const cols = grid[0].length;

    const dfs = (x, y, currentGold) => {
        if (x < 0 || x >= rows || y < 0 || y >= cols || grid[x][y] === 0) {
            maxGold = Math.max(maxGold, currentGold);
            return;
        }

        const gold = grid[x][y];
        grid[x][y] = 0; // Mark as visited

        dfs(x + 1, y, currentGold + gold);
        dfs(x - 1, y, currentGold + gold);
        dfs(x, y + 1, currentGold + gold);
        dfs(x, y - 1, currentGold + gold);

        grid[x][y] = gold; // Backtrack
    };

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] > 0) {
                dfs(i, j, 0);
            }
        }
    }

    return maxGold;
};