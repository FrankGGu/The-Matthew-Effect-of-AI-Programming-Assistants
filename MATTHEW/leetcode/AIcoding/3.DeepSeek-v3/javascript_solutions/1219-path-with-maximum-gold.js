var getMaximumGold = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let maxGold = 0;

    const dfs = (i, j, currentGold) => {
        if (i < 0 || i >= m || j < 0 || j >= n || grid[i][j] === 0) {
            return;
        }
        const gold = grid[i][j];
        currentGold += gold;
        maxGold = Math.max(maxGold, currentGold);
        grid[i][j] = 0;

        dfs(i + 1, j, currentGold);
        dfs(i - 1, j, currentGold);
        dfs(i, j + 1, currentGold);
        dfs(i, j - 1, currentGold);

        grid[i][j] = gold;
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] !== 0) {
                dfs(i, j, 0);
            }
        }
    }

    return maxGold;
};