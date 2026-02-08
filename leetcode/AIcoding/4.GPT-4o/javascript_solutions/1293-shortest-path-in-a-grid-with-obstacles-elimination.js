var shortestPath = function(grid, k) {
    const m = grid.length, n = grid[0].length;
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    const queue = [[0, 0, 0, k]]; // [x, y, steps, remaining_k]
    const visited = new Set();
    visited.add(`0,0,${k}`);

    if (m === 1 && n === 1) return 0;

    while (queue.length) {
        const [x, y, steps, remaining_k] = queue.shift();

        for (const [dx, dy] of directions) {
            const nx = x + dx, ny = y + dy;

            if (nx < 0 || nx >= m || ny < 0 || ny >= n) continue;
            const new_k = remaining_k - grid[nx][ny];

            if (new_k >= 0 && !visited.has(`${nx},${ny},${new_k}`)) {
                if (nx === m - 1 && ny === n - 1) return steps + 1;
                visited.add(`${nx},${ny},${new_k}`);
                queue.push([nx, ny, steps + 1, new_k]);
            }
        }
    }

    return -1;
};