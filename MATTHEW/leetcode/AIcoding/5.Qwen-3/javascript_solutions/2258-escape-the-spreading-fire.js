function maximumMinutes(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    function bfs(starts, time) {
        const dist = Array.from({ length: rows }, () => Array(cols).fill(-1));
        const queue = [];
        for (const [r, c] of starts) {
            dist[r][c] = time;
            queue.push([r, c]);
        }
        while (queue.length > 0) {
            const [r, c] = queue.shift();
            for (const [dr, dc] of dirs) {
                const nr = r + dr;
                const nc = c + dc;
                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && dist[nr][nc] === -1 && grid[nr][nc] !== 1) {
                    dist[nr][nc] = dist[r][c] + 1;
                    queue.push([nr, nc]);
                }
            }
        }
        return dist;
    }

    function canEscape(time) {
        const fireDist = bfs([[0, 0]], 0);
        const personDist = bfs([[0, 0]], 0);
        for (let r = 0; r < rows; r++) {
            for (let c = 0; c < cols; c++) {
                if (grid[r][c] === 1) {
                    fireDist[r][c] = 0;
                }
            }
        }
        const fireQueue = [];
        for (let r = 0; r < rows; r++) {
            for (let c = 0; c < cols; c++) {
                if (grid[r][c] === 1) {
                    fireQueue.push([r, c]);
                }
            }
        }
        const fireDist2 = bfs(fireQueue, 0);
        for (let r = 0; r < rows; r++) {
            for (let c = 0; c < cols; c++) {
                if (grid[r][c] === 0) {
                    if (fireDist2[r][c] < personDist[r][c] - time || (fireDist2[r][c] === personDist[r][c] - time && r === rows - 1 && c === cols - 1)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    let left = 0;
    let right = 500000;
    while (left < right) {
        const mid = Math.ceil((left + right) / 2);
        if (canEscape(mid)) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }
    return left;
}