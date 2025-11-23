function maxDistance(grid) {
    const n = grid.length;
    const queue = [];
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                queue.push([i, j]);
            }
        }
    }

    if (queue.length === 0 || queue.length === n * n) {
        return 0;
    }

    let distance = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const [x, y] = queue.shift();
            for (const [dx, dy] of directions) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < n && ny >= 0 && ny < n && grid[nx][ny] === 0) {
                    grid[nx][ny] = 1;
                    queue.push([nx, ny]);
                }
            }
        }
        distance++;
    }

    return distance - 1;
}