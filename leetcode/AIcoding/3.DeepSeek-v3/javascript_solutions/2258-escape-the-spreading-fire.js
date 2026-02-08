var maximumMinutes = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    const fireSpread = Array(m).fill().map(() => Array(n).fill(Infinity));
    const queue = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                fireSpread[i][j] = 0;
                queue.push([i, j]);
            }
        }
    }

    let time = 0;
    while (queue.length) {
        const len = queue.length;
        time++;
        for (let i = 0; i < len; i++) {
            const [x, y] = queue.shift();
            for (const [dx, dy] of dirs) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] === 0 && fireSpread[nx][ny] === Infinity) {
                    fireSpread[nx][ny] = time;
                    queue.push([nx, ny]);
                }
            }
        }
    }

    const canReach = (wait) => {
        const visited = Array(m).fill().map(() => Array(n).fill(false));
        const q = [[0, 0, wait]];
        visited[0][0] = true;

        while (q.length) {
            const [x, y, t] = q.shift();
            if (x === m - 1 && y === n - 1) {
                return true;
            }
            for (const [dx, dy] of dirs) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] === 0 && !visited[nx][ny]) {
                    if (nx === m - 1 && ny === n - 1) {
                        if (fireSpread[nx][ny] >= t + 1) {
                            return true;
                        }
                    }
                    if (fireSpread[nx][ny] > t + 1) {
                        visited[nx][ny] = true;
                        q.push([nx, ny, t + 1]);
                    }
                }
            }
        }
        return false;
    };

    let left = 0;
    let right = m * n;
    let res = -1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (canReach(mid)) {
            res = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return res;
};