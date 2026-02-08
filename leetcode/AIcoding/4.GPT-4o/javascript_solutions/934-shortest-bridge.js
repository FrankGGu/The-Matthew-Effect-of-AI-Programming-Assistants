var shortestBridge = function(grid) {
    const n = grid.length;
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    let queue = [];

    const dfs = (x, y) => {
        if (x < 0 || x >= n || y < 0 || y >= n || grid[x][y] !== 1) return;
        grid[x][y] = 2;
        queue.push([x, y]);
        for (const [dx, dy] of directions) {
            dfs(x + dx, y + dy);
        }
    };

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                dfs(i, j);
                break;
            }
        }
        if (queue.length) break;
    }

    let steps = 0;
    while (queue.length) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const [x, y] = queue.shift();
            for (const [dx, dy] of directions) {
                const nx = x + dx, ny = y + dy;
                if (nx < 0 || nx >= n || ny < 0 || ny >= n) continue;
                if (grid[nx][ny] === 1) return steps;
                if (grid[nx][ny] === 0) {
                    grid[nx][ny] = 2;
                    queue.push([nx, ny]);
                }
            }
        }
        steps++;
    }

    return -1;
};