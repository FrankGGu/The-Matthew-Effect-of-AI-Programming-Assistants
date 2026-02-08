var maxDistance = function(grid) {
    const n = grid.length;
    const m = grid[0].length;
    const queue = [];
    let landCount = 0;

    for (let r = 0; r < n; r++) {
        for (let c = 0; c < m; c++) {
            if (grid[r][c] === 1) {
                queue.push([r, c, 0]);
                landCount++;
            }
        }
    }

    if (landCount === 0 || landCount === n * m) {
        return -1;
    }

    let maxDist = -1;
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0) {
        const [r, c, dist] = queue.shift();
        maxDist = Math.max(maxDist, dist);

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < n && nc >= 0 && nc < m && grid[nr][nc] === 0) {
                grid[nr][nc] = 1; // Mark as visited (effectively turning water into land for BFS purposes)
                queue.push([nr, nc, dist + 1]);
            }
        }
    }

    return maxDist;
};