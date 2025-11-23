function containsCycle(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const visited = Array.from({ length: m }, () => Array(n).fill(false));

    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    function dfs(r, c, pr, pc, color) {
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] !== color) {
            return false;
        }
        if (visited[r][c]) {
            return true;
        }
        visited[r][c] = true;
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr === pr && nc === pc) continue;
            if (dfs(nr, nc, r, c, color)) {
                return true;
            }
        }
        return false;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (!visited[i][j]) {
                if (dfs(i, j, -1, -1, grid[i][j])) {
                    return true;
                }
            }
        }
    }
    return false;
}