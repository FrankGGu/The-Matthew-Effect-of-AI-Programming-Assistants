function minMovesToReachTarget(grid) {
    const n = grid.length;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const rotations = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [1, -1], [-1, -1]];

    const visited = new Set();
    const queue = [];

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                queue.push([i, j, 0, 0]);
                visited.add(`${i},${j},0,0`);
            }
        }
    }

    while (queue.length > 0) {
        const [x, y, dir, steps] = queue.shift();

        if (grid[x][y] === 1) {
            return steps;
        }

        for (let i = 0; i < directions.length; i++) {
            const [dx, dy] = directions[i];
            const nx = x + dx;
            const ny = y + dy;

            if (nx >= 0 && ny >= 0 && nx < n && ny < n && grid[nx][ny] === 0) {
                const key = `${nx},${ny},${i},${steps + 1}`;
                if (!visited.has(key)) {
                    visited.add(key);
                    queue.push([nx, ny, i, steps + 1]);
                }
            }
        }

        for (let i = 0; i < rotations.length; i++) {
            const [dx, dy] = rotations[i];
            const nx = x + dx;
            const ny = y + dy;

            if (nx >= 0 && ny >= 0 && nx < n && ny < n && grid[nx][ny] === 0) {
                const newDir = (dir + 1) % 4;
                const key = `${nx},${ny},${newDir},${steps + 1}`;
                if (!visited.has(key)) {
                    visited.add(key);
                    queue.push([nx, ny, newDir, steps + 1]);
                }
            }
        }
    }

    return -1;
}