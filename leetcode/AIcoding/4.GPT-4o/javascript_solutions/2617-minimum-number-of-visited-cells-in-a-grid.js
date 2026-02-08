var minimumVisitedCells = function(grid) {
    const m = grid.length, n = grid[0].length;
    const dist = Array.from({ length: m }, () => Array(n).fill(Infinity));
    const queue = [[0, 0]];
    dist[0][0] = 1;

    for (let i = 0; i < queue.length; i++) {
        const [x, y] = queue[i];
        const steps = dist[x][y] + 1;

        for (let dx = 1; dx <= grid[x][y]; dx++) {
            const nx = x + dx;
            if (nx >= m) break;
            if (dist[nx][y] > steps) {
                dist[nx][y] = steps;
                queue.push([nx, y]);
            }
        }

        for (let dy = 1; dy <= grid[x][y]; dy++) {
            const ny = y + dy;
            if (ny >= n) break;
            if (dist[x][ny] > steps) {
                dist[x][ny] = steps;
                queue.push([x, ny]);
            }
        }
    }

    return dist[m - 1][n - 1] === Infinity ? -1 : dist[m - 1][n - 1];
};