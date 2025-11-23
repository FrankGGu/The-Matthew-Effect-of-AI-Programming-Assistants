var minimumEffortPath = function(heights) {
    const m = heights.length, n = heights[0].length;
    const efforts = Array.from({ length: m }, () => Array(n).fill(Infinity));
    efforts[0][0] = 0;

    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    const pq = new MinPriorityQueue();
    pq.enqueue([0, 0, 0]); // [effort, x, y]

    while (!pq.isEmpty()) {
        const [effort, x, y] = pq.dequeue().element;

        if (x === m - 1 && y === n - 1) return effort;

        for (const [dx, dy] of directions) {
            const nx = x + dx, ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                const newEffort = Math.max(effort, Math.abs(heights[x][y] - heights[nx][ny]));
                if (newEffort < efforts[nx][ny]) {
                    efforts[nx][ny] = newEffort;
                    pq.enqueue([newEffort, nx, ny]);
                }
            }
        }
    }

    return 0;
};