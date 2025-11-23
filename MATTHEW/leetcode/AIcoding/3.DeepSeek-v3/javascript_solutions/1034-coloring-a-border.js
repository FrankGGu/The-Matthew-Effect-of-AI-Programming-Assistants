var colorBorder = function(grid, row, col, color) {
    const originalColor = grid[row][col];
    if (originalColor === color) return grid;

    const m = grid.length;
    const n = grid[0].length;
    const visited = new Array(m).fill().map(() => new Array(n).fill(false));
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    const dfs = (r, c) => {
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] !== originalColor || visited[r][c]) {
            return;
        }
        visited[r][c] = true;
        let isBorder = false;

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr < 0 || nr >= m || nc < 0 || nc >= n || grid[nr][nc] !== originalColor) {
                isBorder = true;
            } else if (!visited[nr][nc]) {
                dfs(nr, nc);
            }
        }

        if (isBorder) {
            grid[r][c] = color;
        }
    };

    dfs(row, col);
    return grid;
};