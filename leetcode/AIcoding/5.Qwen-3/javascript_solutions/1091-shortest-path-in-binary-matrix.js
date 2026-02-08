function shortestPathBinaryMatrix(grid) {
    const n = grid.length;
    if (grid[0][0] !== 0 || grid[n - 1][n - 1] !== 0) return -1;

    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],          [0, 1],
        [1, -1],  [1, 0], [1, 1]
    ];

    const queue = [[0, 0]];
    grid[0][0] = 1;

    while (queue.length > 0) {
        const [x, y] = queue.shift();
        const distance = grid[x][y];

        if (x === n - 1 && y === n - 1) return distance;

        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && ny >= 0 && nx < n && ny < n && grid[nx][ny] === 0) {
                grid[nx][ny] = distance + 1;
                queue.push([nx, ny]);
            }
        }
    }

    return -1;
}