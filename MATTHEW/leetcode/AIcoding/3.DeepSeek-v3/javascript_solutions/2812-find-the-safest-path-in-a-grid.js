var maximumSafenessFactor = function(grid) {
    const n = grid.length;
    if (grid[0][0] === 1 || grid[n - 1][n - 1] === 1) return 0;

    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const dist = Array.from({ length: n }, () => Array(n).fill(Infinity));
    const queue = [];

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                dist[i][j] = 0;
                queue.push([i, j]);
            }
        }
    }

    while (queue.length) {
        const [i, j] = queue.shift();
        for (const [di, dj] of dirs) {
            const ni = i + di;
            const nj = j + dj;
            if (ni >= 0 && ni < n && nj >= 0 && nj < n && dist[ni][nj] === Infinity) {
                dist[ni][nj] = dist[i][j] + 1;
                queue.push([ni, nj]);
            }
        }
    }

    let left = 0, right = Math.min(dist[0][0], dist[n - 1][n - 1]);
    let res = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (canReach(mid, dist, n)) {
            res = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return res;
};

function canReach(minDist, dist, n) {
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const visited = Array.from({ length: n }, () => Array(n).fill(false));
    const queue = [];
    if (dist[0][0] >= minDist) {
        queue.push([0, 0]);
        visited[0][0] = true;
    }

    while (queue.length) {
        const [i, j] = queue.shift();
        if (i === n - 1 && j === n - 1) return true;
        for (const [di, dj] of dirs) {
            const ni = i + di;
            const nj = j + dj;
            if (ni >= 0 && ni < n && nj >= 0 && nj < n && !visited[ni][nj] && dist[ni][nj] >= minDist) {
                visited[ni][nj] = true;
                queue.push([ni, nj]);
            }
        }
    }
    return false;
}