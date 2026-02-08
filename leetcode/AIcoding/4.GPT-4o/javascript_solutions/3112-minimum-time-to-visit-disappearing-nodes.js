var minimumTime = function(grid) {
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const m = grid.length, n = grid[0].length;
    const minTime = Array.from({ length: m }, () => Array(n).fill(Infinity));
    const queue = [];

    minTime[0][0] = 0;
    queue.push([0, 0, 0]); // [row, col, time]

    while (queue.length) {
        const [x, y, t] = queue.shift();

        for (const [dx, dy] of directions) {
            const nx = x + dx, ny = y + dy;
            if (nx < 0 || nx >= m || ny < 0 || ny >= n) continue;

            const newTime = t + 1 + Math.floor((grid[nx][ny] - t) / 2);
            if (newTime < minTime[nx][ny]) {
                minTime[nx][ny] = newTime;
                queue.push([nx, ny, newTime]);
            }
        }
    }

    return minTime[m - 1][n - 1] === Infinity ? -1 : minTime[m - 1][n - 1];
};