var minimumTime = function(grid) {
    if (grid[0][1] > 1 && grid[1][0] > 1) return -1;
    const m = grid.length, n = grid[0].length;
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const visited = Array.from({ length: m }, () => new Array(n).fill(Infinity));
    visited[0][0] = 0;
    const pq = new MinPriorityQueue({ priority: x => x[0] });
    pq.enqueue([0, 0, 0]);

    while (!pq.isEmpty()) {
        const [time, i, j] = pq.dequeue().element;
        if (i === m - 1 && j === n - 1) return time;
        for (const [di, dj] of dirs) {
            const ni = i + di, nj = j + dj;
            if (ni < 0 || ni >= m || nj < 0 || nj >= n) continue;
            const wait = (grid[ni][nj] - time) % 2 === 0 ? 1 : 0;
            const newTime = Math.max(time + 1, grid[ni][nj] + wait);
            if (newTime < visited[ni][nj]) {
                visited[ni][nj] = newTime;
                pq.enqueue([newTime, ni, nj]);
            }
        }
    }
    return -1;
};