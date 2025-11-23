var colorBorder = function(grid, row, col, color) {
    const m = grid.length;
    const n = grid[0].length;
    const originalColor = grid[row][col];
    const visited = Array(m).fill(null).map(() => Array(n).fill(false));

    function isBorder(i, j) {
        return i === 0 || i === m - 1 || j === 0 || j === n - 1 ||
               grid[i - 1]?.[j] !== originalColor ||
               grid[i + 1]?.[j] !== originalColor ||
               grid[i][j - 1] !== originalColor ||
               grid[i][j + 1] !== originalColor;
    }

    function dfs(i, j) {
        if (i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || grid[i][j] !== originalColor) {
            return;
        }

        visited[i][j] = true;

        if (isBorder(i, j)) {
            grid[i][j] = color;
        }

        dfs(i + 1, j);
        dfs(i - 1, j);
        dfs(i, j + 1);
        dfs(i, j - 1);
    }

    dfs(row, col);
    return grid;
};