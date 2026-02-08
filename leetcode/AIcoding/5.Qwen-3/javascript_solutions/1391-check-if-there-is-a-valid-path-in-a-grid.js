function hasValidPath(grid) {
    const directions = {
        1: [[0, -1], [0, 1]],
        2: [[-1, 0], [1, 0]],
        3: [[0, -1], [1, 0]],
        4: [[0, 1], [1, 0]],
        5: [[0, 1], [-1, 0]],
        6: [[0, -1], [-1, 0]]
    };

    const m = grid.length;
    const n = grid[0].length;

    const visited = new Array(m).fill().map(() => new Array(n).fill(false));

    function dfs(r, c) {
        if (r === m - 1 && c === n - 1) return true;
        visited[r][c] = true;

        for (const [dr, dc] of directions[grid[r][c]]) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc]) {
                const nextDir = directions[grid[nr][nc]];
                for (const [drr, dcc] of nextDir) {
                    if (nr + drr === r && nc + dcc === c) {
                        if (dfs(nr, nc)) return true;
                    }
                }
            }
        }

        return false;
    }

    return dfs(0, 0);
}