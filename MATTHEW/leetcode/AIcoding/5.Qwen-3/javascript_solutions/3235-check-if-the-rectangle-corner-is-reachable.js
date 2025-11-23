function isReachable(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    function bfs(startX, startY) {
        const visited = new Array(m).fill().map(() => new Array(n).fill(false));
        const queue = [[startX, startY]];
        visited[startX][startY] = true;

        while (queue.length > 0) {
            const [x, y] = queue.shift();
            for (const [dx, dy] of directions) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && grid[nx][ny] === 0) {
                    if (grid[nx + 1] && grid[nx + 1][ny] === 0 && grid[nx][ny + 1] === 0 && grid[nx + 1][ny + 1] === 0) {
                        return true;
                    }
                    visited[nx][ny] = true;
                    queue.push([nx, ny]);
                }
            }
        }
        return false;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                if (bfs(i, j)) {
                    return true;
                }
            }
        }
    }
    return false;
}