var shortestPathBinaryMatrix = function(grid) {
    const n = grid.length;

    if (grid[0][0] === 1 || grid[n - 1][n - 1] === 1) {
        return -1;
    }

    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],           [0, 1],
        [1, -1], [1, 0], [1, 1]
    ];

    const queue = [[0, 0, 1]]; // [row, col, distance]
    const visited = Array(n).fill(0).map(() => Array(n).fill(false));
    visited[0][0] = true;

    while (queue.length > 0) {
        const [r, c, dist] = queue.shift();

        if (r === n - 1 && c === n - 1) {
            return dist;
        }

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < n && nc >= 0 && nc < n && grid[nr][nc] === 0 && !visited[nr][nc]) {
                visited[nr][nc] = true;
                queue.push([nr, nc, dist + 1]);
            }
        }
    }

    return -1;
};