var containsCycle = function(grid) {
    const R = grid.length;
    const C = grid[0].length;
    const visited = Array(R).fill(0).map(() => Array(C).fill(false));

    const dr = [-1, 1, 0, 0]; // up, down
    const dc = [0, 0, -1, 1]; // left, right

    function isValid(r, c) {
        return r >= 0 && r < R && c >= 0 && c < C;
    }

    function dfs(r, c, pr, pc, charToMatch) {
        visited[r][c] = true;

        for (let i = 0; i < 4; i++) {
            const nr = r + dr[i];
            const nc = c + dc[i];

            if (!isValid(nr, nc) || grid[nr][nc] !== charToMatch) {
                continue;
            }

            if (nr === pr && nc === pc) {
                continue;
            }

            if (visited[nr][nc]) {
                return true;
            }

            if (dfs(nr, nc, r, c, charToMatch)) {
                return true;
            }
        }
        return false;
    }

    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            if (!visited[r][c]) {
                if (dfs(r, c, -1, -1, grid[r][c])) {
                    return true;
                }
            }
        }
    }

    return false;
};