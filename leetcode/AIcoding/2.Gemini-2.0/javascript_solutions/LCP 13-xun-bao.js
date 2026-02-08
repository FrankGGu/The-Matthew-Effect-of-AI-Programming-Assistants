var minimalSteps = function(maze) {
    const m = maze.length;
    const n = maze[0].length;
    let sx, sy, ex, ey;
    const stones = [];
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (maze[i][j] === 'S') {
                sx = i;
                sy = j;
            } else if (maze[i][j] === 'E') {
                ex = i;
                ey = j;
            } else if (maze[i][j] === 'M') {
                stones.push([i, j]);
            }
        }
    }

    const bfs = (x1, y1, x2, y2) => {
        const queue = [[x1, y1, 0]];
        const visited = Array(m).fill(null).map(() => Array(n).fill(false));
        visited[x1][y1] = true;
        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        while (queue.length > 0) {
            const [x, y, steps] = queue.shift();

            if (x === x2 && y === y2) {
                return steps;
            }

            for (const [dx, dy] of directions) {
                let nx = x + dx;
                let ny = y + dy;

                while (nx >= 0 && nx < m && ny >= 0 && ny < n && maze[nx][ny] !== '#') {
                    nx += dx;
                    ny += dy;
                }

                nx -= dx;
                ny -= dy;

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && maze[nx][ny] !== '#') {
                    visited[nx][ny] = true;
                    queue.push([nx, ny, steps + 1]);
                }
            }
        }

        return -1;
    };

    const stoneCount = stones.length;
    const dist = Array(stoneCount + 2).fill(null).map(() => Array(stoneCount + 2).fill(0));

    dist[0][stoneCount + 1] = bfs(sx, sy, ex, ey);
    if (dist[0][stoneCount + 1] === -1) return -1;

    for (let i = 0; i < stoneCount; i++) {
        const [x1, y1] = stones[i];
        dist[0][i + 1] = bfs(sx, sy, x1, y1);
        if (dist[0][i + 1] === -1) return -1;
        dist[i + 1][stoneCount + 1] = bfs(x1, y1, ex, ey);
        if (dist[i + 1][stoneCount + 1] === -1) return -1;
        for (let j = i + 1; j < stoneCount; j++) {
            const [x2, y2] = stones[j];
            dist[i + 1][j + 1] = bfs(x1, y1, x2, y2);
            if (dist[i + 1][j + 1] === -1) return -1;
            dist[j + 1][i + 1] = dist[i + 1][j + 1];
        }
    }

    let minSteps = Infinity;
    const visited = Array(stoneCount + 2).fill(false);
    const dfs = (curr, steps) => {
        if (curr === stoneCount + 1) {
            minSteps = Math.min(minSteps, steps);
            return;
        }

        for (let i = 1; i <= stoneCount + 1; i++) {
            if (!visited[i] ) {
                visited[i] = true;
                dfs(i, steps + dist[curr][i]);
                visited[i] = false;
            }
        }
    };

    visited[0] = true;
    dfs(0, 0);

    return minSteps === Infinity ? -1 : minSteps;
};