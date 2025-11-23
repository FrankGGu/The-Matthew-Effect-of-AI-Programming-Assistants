function guardTarget(grid, guards, walls) {
    const m = grid.length;
    const n = grid[0].length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    const queue = [];
    const visited = Array.from({ length: m }, () => Array(n).fill(false));

    for (const [x, y] of guards) {
        queue.push([x, y]);
        visited[x][y] = true;
    }

    while (queue.length > 0) {
        const [x, y] = queue.shift();

        for (const [dx, dy] of directions) {
            let nx = x + dx;
            let ny = y + dy;

            while (nx >= 0 && ny >= 0 && nx < m && ny < n && !visited[nx][ny]) {
                if (grid[nx][ny] === 'W') break;
                if (grid[nx][ny] === 'T') {
                    return true;
                }
                visited[nx][ny] = true;
                queue.push([nx, ny]);
                nx += dx;
                ny += dy;
            }
        }
    }

    return false;
}