var getMaxGridHappiness = function(m, n, introvertsCount, extrovertsCount) {
    const dp = new Map();
    const happiness = (grid) => {
        let happy = 0;
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (grid[i][j] === 1) {
                    happy += 120;
                    if (i > 0 && grid[i - 1][j] === 1) happy -= 30;
                    if (j > 0 && grid[i][j - 1] === 1) happy -= 30;
                } else if (grid[i][j] === 2) {
                    happy += 40;
                    if (i > 0 && grid[i - 1][j] === 2) happy -= 20;
                    if (j > 0 && grid[i][j - 1] === 2) happy -= 20;
                }
            }
        }
        return happy;
    };

    const dfs = (grid, i, j, introvertsCount, extrovertsCount) => {
        if (i === m) return happiness(grid);
        if (j === n) return dfs(grid, i + 1, 0, introvertsCount, extrovertsCount);
        let maxHappiness = dfs(grid, i, j + 1, introvertsCount, extrovertsCount);

        if (introvertsCount > 0) {
            grid[i][j] = 1;
            maxHappiness = Math.max(maxHappiness, dfs(grid, i, j + 1, introvertsCount - 1, extrovertsCount) + happiness(grid));
            grid[i][j] = 0;
        }

        if (extrovertsCount > 0) {
            grid[i][j] = 2;
            maxHappiness = Math.max(maxHappiness, dfs(grid, i, j + 1, introvertsCount, extrovertsCount - 1) + happiness(grid));
            grid[i][j] = 0;
        }

        return maxHappiness;
    };

    return dfs(Array.from({length: m}, () => Array(n).fill(0)), 0, 0, introvertsCount, extrovertsCount);
};