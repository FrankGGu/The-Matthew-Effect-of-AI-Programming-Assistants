function maxPoints(grid, queries) {
    const m = grid.length;
    const n = grid[0].length;
    const points = new Array(m * n).fill(0);
    const visited = new Array(m * n).fill(false);
    const heap = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            points[i * n + j] = grid[i][j];
        }
    }

    points.sort((a, b) => a - b);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (!visited[i * n + j]) {
                const queue = [[i, j]];
                visited[i * n + j] = true;
                const component = [];
                while (queue.length > 0) {
                    const [x, y] = queue.shift();
                    component.push(grid[x][y]);
                    for (const [dx, dy] of [[-1, 0], [1, 0], [0, -1], [0, 1]]) {
                        const nx = x + dx;
                        const ny = y + dy;
                        if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx * n + ny]) {
                            visited[nx * n + ny] = true;
                            queue.push([nx, ny]);
                        }
                    }
                }
                component.sort((a, b) => a - b);
                for (let k = 0; k < component.length; k++) {
                    points.push(component[k]);
                }
            }
        }
    }

    points.sort((a, b) => a - b);

    const map = {};
    let count = 0;
    for (const p of points) {
        if (!map[p]) {
            map[p] = count++;
        }
    }

    const result = new Array(queries.length).fill(0);
    for (let i = 0; i < queries.length; i++) {
        const q = queries[i];
        let left = 0, right = points.length - 1;
        let ans = 0;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (points[mid] <= q) {
                ans = map[points[mid]] + 1;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        result[i] = ans;
    }

    return result;
}