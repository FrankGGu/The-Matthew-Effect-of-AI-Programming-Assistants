var swimInWater = function(grid) {
    const n = grid.length;
    const directions = [[1, 0], [0, 1], [-1, 0], [0, -1]];
    const minHeap = new MinPriorityQueue({ priority: x => x[0] });
    const visited = Array.from({ length: n }, () => Array(n).fill(false));

    minHeap.enqueue([grid[0][0], 0, 0]);
    visited[0][0] = true;

    while (minHeap.size()) {
        const [time, x, y] = minHeap.dequeue().element;
        if (x === n - 1 && y === n - 1) return time;

        for (const [dx, dy] of directions) {
            const nx = x + dx, ny = y + dy;
            if (nx >= 0 && ny >= 0 && nx < n && ny < n && !visited[nx][ny]) {
                visited[nx][ny] = true;
                minHeap.enqueue([Math.max(time, grid[nx][ny]), nx, ny]);
            }
        }
    }
};