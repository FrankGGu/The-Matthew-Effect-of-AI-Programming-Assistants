function findMinimumEffortPath(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const dist = Array.from({ length: rows }, () => Array(cols).fill(Infinity));
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    const heap = [];
    heap.push([0, 0, 0]);
    dist[0][0] = 0;

    while (heap.length > 0) {
        const [effort, x, y] = heap.shift();

        if (x === rows - 1 && y === cols - 1) {
            return effort;
        }

        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
                const newEffort = Math.max(effort, Math.abs(grid[nx][ny] - grid[x][y]));
                if (newEffort < dist[nx][ny]) {
                    dist[nx][ny] = newEffort;
                    heap.push([newEffort, nx, ny]);
                }
            }
        }
    }

    return dist[rows - 1][cols - 1];
}