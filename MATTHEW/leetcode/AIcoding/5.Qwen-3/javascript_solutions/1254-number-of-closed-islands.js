function closedIslands(grid) {
    if (!grid || grid.length === 0) return 0;

    const rows = grid.length;
    const cols = grid[0].length;
    let count = 0;

    function dfs(r, c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] === 0) {
            return;
        }
        grid[r][c] = 0;
        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                let isClosed = true;
                const queue = [[i, j]];
                grid[i][j] = 0;
                while (queue.length > 0) {
                    const [r, c] = queue.shift();
                    if (r === 0 || r === rows - 1 || c === 0 || c === cols - 1) {
                        isClosed = false;
                    }
                    for (const [dr, dc] of [[-1, 0], [1, 0], [0, -1], [0, 1]]) {
                        const nr = r + dr;
                        const nc = c + dc;
                        if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] === 1) {
                            grid[nr][nc] = 0;
                            queue.push([nr, nc]);
                        }
                    }
                }
                if (isClosed) count++;
            }
        }
    }

    return count;
}