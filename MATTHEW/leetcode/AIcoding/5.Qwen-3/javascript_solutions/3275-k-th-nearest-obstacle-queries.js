function distance(p1, p2) {
    return Math.abs(p1[0] - p2[0]) + Math.abs(p1[1] - p2[1]);
}

function kthNearestObstacleQueries(grid, queries) {
    const m = grid.length;
    const n = grid[0].length;
    const result = [];

    for (const [x, y, k] of queries) {
        const obstacles = [];
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (grid[i][j] === 1) {
                    obstacles.push([i, j]);
                }
            }
        }

        obstacles.sort((a, b) => distance(a, [x, y]) - distance(b, [x, y]));
        result.push(obstacles[k - 1]);
    }

    return result;
}