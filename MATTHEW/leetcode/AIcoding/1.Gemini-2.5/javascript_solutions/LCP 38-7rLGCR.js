var guardCastle = function(grid) {
    const m = grid.length;
    const n = grid[0.length;

    const dist = Array(m).fill(0).map(() => Array(n).fill(-1));
    const queue = [];

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 2) {
                dist[r][c] = 0;
                queue.push([r, c]);
            }
        }
    }

    const dr = [-1, 1, 0, 0];
    const dc = [0, 0, -1, 1];

    let head = 0;
    while (head < queue.length) {
        const [r, c] = queue[head++];

        for (let i = 0; i < 4; i++) {
            const nr = r + dr[i];
            const nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] !== 1 && dist[nr][nc] === -1) {
                dist[nr][nc] = dist[r][c] + 1;
                queue.push([nr, nc]);
            }
        }
    }

    return dist;
};