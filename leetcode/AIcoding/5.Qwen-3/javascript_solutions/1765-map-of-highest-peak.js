var highestPeak = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const queue = [];
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                queue.push([i, j]);
            } else {
                grid[i][j] = -1;
            }
        }
    }

    while (queue.length > 0) {
        const [x, y] = queue.shift();
        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && ny >= 0 && nx < m && ny < n && grid[nx][ny] === -1) {
                grid[nx][ny] = grid[x][y] + 1;
                queue.push([nx, ny]);
            }
        }
    }

    return grid;
};