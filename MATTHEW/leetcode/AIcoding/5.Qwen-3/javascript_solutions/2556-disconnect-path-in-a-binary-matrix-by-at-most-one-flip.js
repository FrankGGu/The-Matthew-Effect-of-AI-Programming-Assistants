function isPossible(grid) {
    const m = grid.length;
    const n = grid[0].length;

    function bfs(startRow, startCol) {
        const visited = new Array(m).fill().map(() => new Array(n).fill(false));
        const queue = [[startRow, startCol]];
        visited[startRow][startCol] = true;

        while (queue.length > 0) {
            const [r, c] = queue.shift();
            if (r === m - 1 && c === n - 1) return true;
            for (const [dr, dc] of [[-1, 0], [1, 0], [0, -1], [0, 1]]) {
                const nr = r + dr;
                const nc = c + dc;
                if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc] && grid[nr][nc] === 1) {
                    visited[nr][nc] = true;
                    queue.push([nr, nc]);
                }
            }
        }
        return false;
    }

    if (bfs(0, 0)) return true;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                grid[i][j] = 0;
                if (bfs(0, 0)) {
                    grid[i][j] = 1;
                    return true;
                }
                grid[i][j] = 1;
            }
        }
    }

    return false;
}