function isGridCut(grid) {
    const rows = grid.length;
    const cols = grid[0].length;

    function dfs(r, c, visited) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] === 0 || visited[r][c]) {
            return false;
        }
        visited[r][c] = true;
        const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (dfs(nr, nc, visited)) {
                return true;
            }
        }
        return false;
    }

    const visited = Array.from({ length: rows }, () => Array(cols).fill(false));
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1 && !visited[i][j]) {
                if (!dfs(i, j, visited)) {
                    return false;
                }
            }
        }
    }
    return true;
}