function shortestPath(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const visited = Array.from({ length: m }, () => Array(n).fill(-1));
    const queue = [[0, 0, k]];
    visited[0][0] = k;
    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const [x, y, rem] = queue.shift();
            if (x === m - 1 && y === n - 1) return steps;
            for (const [dx, dy] of [[-1, 0], [1, 0], [0, -1], [0, 1]]) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    const newRem = rem - grid[nx][ny];
                    if (newRem >= 0 && visited[nx][ny] < newRem) {
                        visited[nx][ny] = newRem;
                        queue.push([nx, ny, newRem]);
                    }
                }
            }
        }
        steps++;
    }

    return -1;
}