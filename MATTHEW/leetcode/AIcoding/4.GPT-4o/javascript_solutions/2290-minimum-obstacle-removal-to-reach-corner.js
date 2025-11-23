var minimumObstacles = function(grid) {
    const m = grid.length, n = grid[0].length;
    const directions = [[1, 0], [0, 1], [-1, 0], [0, -1]];
    const pq = new MinPriorityQueue();
    const dist = Array.from({ length: m }, () => Array(n).fill(Infinity));
    dist[0][0] = 0;
    pq.enqueue([0, 0], 0);

    while (!pq.isEmpty()) {
        const [x, y] = pq.dequeue().element;

        if (x === m - 1 && y === n - 1) return dist[x][y];

        for (const [dx, dy] of directions) {
            const nx = x + dx, ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                const newCost = dist[x][y] + grid[nx][ny];
                if (newCost < dist[nx][ny]) {
                    dist[nx][ny] = newCost;
                    pq.enqueue([nx, ny], newCost);
                }
            }
        }
    }

    return dist[m - 1][n - 1];
};