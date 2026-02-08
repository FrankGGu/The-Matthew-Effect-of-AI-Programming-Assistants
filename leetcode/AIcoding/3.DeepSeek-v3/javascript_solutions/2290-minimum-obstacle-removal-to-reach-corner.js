var minimumObstacles = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const dist = Array.from({ length: m }, () => Array(n).fill(Infinity));
    dist[0][0] = 0;
    const deque = [[0, 0]];

    while (deque.length) {
        const [x, y] = deque.shift();
        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                const newDist = dist[x][y] + grid[nx][ny];
                if (newDist < dist[nx][ny]) {
                    dist[nx][ny] = newDist;
                    if (grid[nx][ny] === 0) {
                        deque.unshift([nx, ny]);
                    } else {
                        deque.push([nx, ny]);
                    }
                }
            }
        }
    }

    return dist[m - 1][n - 1];
};