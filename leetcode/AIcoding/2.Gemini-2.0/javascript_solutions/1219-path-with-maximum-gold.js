var getMaximumGold = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let maxGold = 0;

    function dfs(row, col, currentGold, visited) {
        if (row < 0 || row >= m || col < 0 || col >= n || grid[row][col] === 0 || visited.has(row * n + col)) {
            return currentGold;
        }

        const newVisited = new Set(visited);
        newVisited.add(row * n + col);
        const gold = grid[row][col];

        const up = dfs(row - 1, col, currentGold + gold, newVisited);
        const down = dfs(row + 1, col, currentGold + gold, newVisited);
        const left = dfs(row, col - 1, currentGold + gold, newVisited);
        const right = dfs(row, col + 1, currentGold + gold, newVisited);

        return Math.max(up, down, left, right);
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] !== 0) {
                maxGold = Math.max(maxGold, dfs(i, j, 0, new Set()));
            }
        }
    }

    return maxGold;
};