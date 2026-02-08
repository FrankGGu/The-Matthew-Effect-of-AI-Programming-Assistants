var minimumTime = function(grid, start, end, k) {
    const m = grid.length, n = grid[0].length;
    const directions = [[0,1],[1,0],[0,-1],[-1,0]];
    const pq = new MinPriorityQueue();
    pq.enqueue([start[0], start[1], 0]);
    const visited = new Set();
    visited.add(start[0] + ',' + start[1] + ',0');

    while (!pq.isEmpty()) {
        const [x, y, time] = pq.dequeue().element;

        if (x === end[0] && y === end[1]) return time;

        for (const [dx, dy] of directions) {
            const nx = x + dx, ny = y + dy;
            if (nx < 0 || nx >= m || ny < 0 || ny >= n) continue;

            const waitTime = (time + 1) % k === 0 ? 0 : k - ((time + 1) % k);
            const newTime = time + 1 + waitTime;

            if (newTime < grid[nx][ny] || grid[nx][ny] === 0) {
                grid[nx][ny] = newTime;
                visited.add(nx + ',' + ny + ',' + newTime);
                pq.enqueue([nx, ny, newTime]);
            }
        }
    }
    return -1;
};