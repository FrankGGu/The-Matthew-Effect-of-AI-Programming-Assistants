function colorBorder(grid, row, col, color) {
    const originalColor = grid[row][col];
    const rows = grid.length;
    const cols = grid[0].length;
    const visited = Array.from({ length: rows }, () => Array(cols).fill(false));
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    const border = [];

    function isBorder(r, c) {
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr < 0 || nr >= rows || nc < 0 || nc >= cols || grid[nr][nc] !== originalColor) {
                return true;
            }
        }
        return false;
    }

    function dfs(r, c) {
        visited[r][c] = true;
        if (isBorder(r, c)) {
            border.push([r, c]);
        }
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] === originalColor && !visited[nr][nc]) {
                dfs(nr, nc);
            }
        }
    }

    dfs(row, col);

    for (const [r, c] of border) {
        grid[r][c] = color;
    }

    return grid;
}