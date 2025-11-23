var maximumSafenessFactor = function(grid) {
    const n = grid.length;
    const dist = Array(n).fill(null).map(() => Array(n).fill(Infinity));
    const q = [];

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                dist[i][j] = 0;
                q.push([i, j]);
            }
        }
    }

    const dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (q.length > 0) {
        const [x, y] = q.shift();
        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < n && ny >= 0 && ny < n && dist[nx][ny] === Infinity) {
                dist[nx][ny] = dist[x][y] + 1;
                q.push([nx, ny]);
            }
        }
    }

    let left = 0;
    let right = n;
    let ans = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (canReach(grid, dist, mid)) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;

    function canReach(grid, dist, mid) {
        if (dist[0][0] < mid || dist[n - 1][n - 1] < mid) {
            return false;
        }

        const visited = Array(n).fill(null).map(() => Array(n).fill(false));
        const queue = [[0, 0]];
        visited[0][0] = true;

        while (queue.length > 0) {
            const [x, y] = queue.shift();
            if (x === n - 1 && y === n - 1) {
                return true;
            }

            for (const [dx, dy] of dirs) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny] && dist[nx][ny] >= mid) {
                    visited[nx][ny] = true;
                    queue.push([nx, ny]);
                }
            }
        }

        return false;
    }
};