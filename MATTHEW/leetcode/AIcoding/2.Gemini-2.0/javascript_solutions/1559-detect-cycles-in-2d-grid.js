var containsCycle = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const visited = Array(rows).fill(null).map(() => Array(cols).fill(false));

    function dfs(row, col, parentRow, parentCol, char) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] !== char) {
            return false;
        }

        if (visited[row][col]) {
            return true;
        }

        visited[row][col] = true;

        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols &&
                (newRow !== parentRow || newCol !== parentCol) &&
                grid[newRow][newCol] === char && dfs(newRow, newCol, row, col, char)) {
                return true;
            }
        }

        return false;
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (!visited[i][j] && dfs(i, j, -1, -1, grid[i][j])) {
                return true;
            }
        }
    }

    return false;
};