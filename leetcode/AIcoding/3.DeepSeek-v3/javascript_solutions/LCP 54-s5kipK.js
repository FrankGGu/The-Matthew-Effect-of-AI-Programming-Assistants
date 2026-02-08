var minimumOperations = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const visited = new Array(m).fill().map(() => new Array(n).fill(false));
    let res = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1 && !visited[i][j]) {
                res++;
                const queue = [[i, j]];
                visited[i][j] = true;
                while (queue.length > 0) {
                    const [x, y] = queue.shift();
                    for (const [dx, dy] of dirs) {
                        const nx = x + dx;
                        const ny = y + dy;
                        if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] === 1 && !visited[nx][ny]) {
                            visited[nx][ny] = true;
                            queue.push([nx, ny]);
                        }
                    }
                }
            }
        }
    }

    return res;
};