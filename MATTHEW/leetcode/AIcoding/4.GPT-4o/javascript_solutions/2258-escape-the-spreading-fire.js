var maximumMinutes = function(fire, exit) {
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const rows = fire.length, cols = fire[0].length;

    const bfs = (start, fireSpread) => {
        const queue = [start];
        const visited = Array.from({ length: rows }, () => Array(cols).fill(false));
        visited[start[0]][start[1]] = true;
        let time = 0;

        while (queue.length) {
            const nextQueue = [];
            for (const [r, c] of queue) {
                if (fireSpread[r][c] !== -1 && fireSpread[r][c] <= time) continue;
                for (const [dr, dc] of directions) {
                    const nr = r + dr, nc = c + dc;
                    if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited[nr][nc]) {
                        visited[nr][nc] = true;
                        nextQueue.push([nr, nc]);
                    }
                }
            }
            time++;
            for (const [r, c] of nextQueue) {
                fireSpread[r][c] = Math.min(fireSpread[r][c], time);
            }
            queue.push(...nextQueue);
        }
    };

    const fireSpread = Array.from({ length: rows }, () => Array(cols).fill(Infinity));
    for (const [r, c] of fire) {
        fireSpread[r][c] = 0;
    }
    bfs(fire[0], fireSpread);

    const escapeTime = Array.from({ length: rows }, () => Array(cols).fill(Infinity));
    escapeTime[exit[0]][exit[1]] = 0;
    bfs(exit, escapeTime);

    let maxMinutes = 0;
    for (let t = 0; t <= 2 * rows * cols; t++) {
        if (escapeTime[exit[0]][exit[1]] <= t && t < fireSpread[exit[0]][exit[1]]) {
            maxMinutes = t;
        }
    }

    return maxMinutes > 0 ? Math.min(maxMinutes, 1) : 0;
};