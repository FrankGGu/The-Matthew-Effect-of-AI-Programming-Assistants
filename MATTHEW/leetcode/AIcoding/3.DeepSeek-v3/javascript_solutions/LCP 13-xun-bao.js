var minimalSteps = function(maze) {
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const m = maze.length, n = maze[0].length;
    let start, end;
    const stones = [], machines = [];
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const c = maze[i][j];
            if (c === 'S') start = [i, j];
            else if (c === 'T') end = [i, j];
            else if (c === 'O') stones.push([i, j]);
            else if (c === 'M') machines.push([i, j]);
        }
    }
    const nb = stones.length, nm = machines.length;
    const startDist = bfs(start[0], start[1], maze);
    if (nm === 0) return startDist[end[0]][end[1]];
    const dist = Array(nm).fill().map(() => Array(nm + 2).fill(-1));
    const dd = Array(nm).fill().map(() => Array(nm).fill(0));
    for (let i = 0; i < nm; i++) {
        const d = bfs(machines[i][0], machines[i][1], maze);
        for (let j = 0; j < nm; j++) {
            let minDist = Infinity;
            for (const [x, y] of stones) {
                if (d[x][y] !== -1 && startDist[x][y] !== -1) {
                    minDist = Math.min(minDist, d[x][y] + startDist[x][y]);
                }
            }
            dd[i][j] = minDist;
        }
        for (let j = 0; j < nm; j++) {
            const [x, y] = machines[j];
            dist[i][j] = d[x][y];
        }
        const [x, y] = end;
        dist[i][nm] = d[x][y];
    }
    for (let j = 0; j < nm; j++) {
        let minDist = Infinity;
        for (const [x, y] of stones) {
            if (startDist[x][y] !== -1 && dist[j][nm + 1] === -1) {
                const d = bfs(x, y, maze);
                if (d[machines[j][0]][machines[j][1]] !== -1) {
                    minDist = Math.min(minDist, startDist[x][y] + d[machines[j][0]][machines[j][1]]);
                }
            }
        }
        dist[j][nm + 1] = minDist;
    }
    const dp = Array(1 << nm).fill().map(() => Array(nm).fill(Infinity));
    for (let i = 0; i < nm; i++) {
        dp[1 << i][i] = dd[i][i];
    }
    for (let mask = 1; mask < (1 << nm); mask++) {
        for (let i = 0; i < nm; i++) {
            if (!(mask & (1 << i))) continue;
            for (let j = 0; j < nm; j++) {
                if (mask & (1 << j)) continue;
                const nextMask = mask | (1 << j);
                dp[nextMask][j] = Math.min(dp[nextMask][j], dp[mask][i] + dist[i][j]);
            }
        }
    }
    let res = Infinity;
    const lastMask = (1 << nm) - 1;
    for (let i = 0; i < nm; i++) {
        if (dp[lastMask][i] !== Infinity && dist[i][nm] !== -1) {
            res = Math.min(res, dp[lastMask][i] + dist[i][nm]);
        }
    }
    return res === Infinity ? -1 : res;

    function bfs(sx, sy, maze) {
        const dist = Array(m).fill().map(() => Array(n).fill(-1));
        dist[sx][sy] = 0;
        const q = [[sx, sy]];
        while (q.length) {
            const [x, y] = q.shift();
            for (const [dx, dy] of dirs) {
                const nx = x + dx, ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && maze[nx][ny] !== '#' && dist[nx][ny] === -1) {
                    dist[nx][ny] = dist[x][y] + 1;
                    q.push([nx, ny]);
                }
            }
        }
        return dist;
    }
};