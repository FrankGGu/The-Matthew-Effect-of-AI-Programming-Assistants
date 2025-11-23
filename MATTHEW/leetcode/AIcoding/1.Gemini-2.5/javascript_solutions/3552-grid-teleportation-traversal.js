var gridTeleportationTraversal = function(grid, start, end) {
    const m = grid.length;
    const n = grid[0].length;

    const startR = start[0];
    const startC = start[1];
    const endR = end[0];
    const endC = end[1];

    const dr = [-1, 1, 0, 0];
    const dc = [0, 0, -1, 1];

    const dist = Array(m).fill(0).map(() => Array(n).fill(Infinity));
    const deque = [];

    const teleportPoints = [];
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 2) {
                teleportPoints.push([r, c]);
            }
        }
    }

    if (grid[startR][startC] === 1) {
        return -1; // Start is an obstacle
    }

    dist[startR][startC] = 0;
    deque.push([startR, startC]);

    let teleportationProcessed = false;

    while (deque.length > 0) {
        const [r, c] = deque.shift();

        if (r === endR && c === endC) {
            return dist[r][c];
        }

        for (let i = 0; i < 4; i++) {
            const nr = r + dr[i];
            const nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] !== 1) {
                if (dist[r][c] + 1 < dist[nr][nc]) {
                    dist[nr][nc] = dist[r][c] + 1;
                    deque.push([nr, nc]);
                }
            }
        }

        if (grid[r][c] === 2 && !teleportationProcessed) {
            teleportationProcessed = true;

            for (const [tr, tc] of teleportPoints) {
                if (dist[r][c] < dist[tr][tc]) {
                    dist[tr][tc] = dist[r][c];
                    deque.unshift([tr, tc]);
                }
            }
        }
    }

    return -1;
};