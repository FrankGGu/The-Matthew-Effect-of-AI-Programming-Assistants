var shortestPath = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const visited = new Array(m).fill().map(() => new Array(n).fill(Infinity));
    const queue = [[0, 0, 0, 0]]; // [row, col, steps, obstacles]
    visited[0][0] = 0;

    while (queue.length) {
        const [r, c, steps, obs] = queue.shift();
        if (r === m - 1 && c === n - 1) return steps;

        for (const [dr, dc] of dirs) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                const newObs = obs + grid[nr][nc];
                if (newObs <= k && newObs < visited[nr][nc]) {
                    visited[nr][nc] = newObs;
                    queue.push([nr, nc, steps + 1, newObs]);
                }
            }
        }
    }

    return -1;
};