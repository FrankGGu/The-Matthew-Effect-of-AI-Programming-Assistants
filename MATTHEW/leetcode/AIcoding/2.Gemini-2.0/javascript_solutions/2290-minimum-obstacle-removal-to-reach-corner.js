var minimumObstacles = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dist = Array(m).fill(null).map(() => Array(n).fill(Infinity));
    dist[0][0] = 0;
    const priorityQueue = [[0, 0, 0]]; // [distance, row, col]

    while (priorityQueue.length > 0) {
        priorityQueue.sort((a, b) => a[0] - b[0]);
        const [d, r, c] = priorityQueue.shift();

        if (d > dist[r][c]) {
            continue;
        }

        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                const newDist = d + grid[nr][nc];
                if (newDist < dist[nr][nc]) {
                    dist[nr][nc] = newDist;
                    priorityQueue.push([newDist, nr, nc]);
                }
            }
        }
    }

    return dist[m - 1][n - 1];
};