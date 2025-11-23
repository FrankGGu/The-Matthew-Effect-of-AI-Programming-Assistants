var kHighestRankedKItems = function(grid, pricing, start, k) {
    const [low, high] = pricing;
    const [row, col] = start;
    const m = grid.length;
    const n = grid[0].length;

    const items = [];
    const visited = Array(m).fill(null).map(() => Array(n).fill(false));
    const queue = [[row, col, 0]];
    visited[row][col] = true;

    while (queue.length > 0) {
        const [r, c, dist] = queue.shift();
        const price = grid[r][c];

        if (price >= low && price <= high) {
            items.push([dist, price, r, c]);
        }

        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] !== 0 && !visited[nr][nc]) {
                queue.push([nr, nc, dist + 1]);
                visited[nr][nc] = true;
            }
        }
    }

    items.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        if (a[1] !== b[1]) {
            return a[1] - b[1];
        }
        if (a[2] !== b[2]) {
            return a[2] - b[2];
        }
        return a[3] - b[3];
    });

    const result = [];
    for (let i = 0; i < Math.min(k, items.length); i++) {
        result.push([items[i][2], items[i][3]]);
    }

    return result;
};