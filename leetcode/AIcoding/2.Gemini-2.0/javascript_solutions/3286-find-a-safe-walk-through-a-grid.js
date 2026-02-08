var findSafeWalk = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const safeGrid = Array(m).fill(null).map(() => Array(n).fill(0));
    const visited = Array(m).fill(null).map(() => Array(n).fill(false));

    const isValid = (row, col) => {
        return row >= 0 && row < m && col >= 0 && col < n && grid[row][col] === 0;
    };

    const dfs = (row, col) => {
        if (!isValid(row, col) || visited[row][col]) {
            return false;
        }

        if (row === m - 1 && col === n - 1) {
            safeGrid[row][col] = 1;
            return true;
        }

        visited[row][col] = true;

        const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (dfs(newRow, newCol)) {
                safeGrid[row][col] = 1;
                return true;
            }
        }

        return false;
    };

    dfs(0, 0);

    return safeGrid;
};