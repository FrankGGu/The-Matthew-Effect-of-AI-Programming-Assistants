var shortestPathAllKeys = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let startX = -1, startY = -1;
    let keyCount = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === '@') {
                startX = i;
                startY = j;
            } else if (grid[i][j] >= 'a' && grid[i][j] <= 'f') {
                keyCount = Math.max(keyCount, grid[i].charCodeAt(j) - 'a'.charCodeAt(0) + 1);
            }
        }
    }

    const targetKeys = (1 << keyCount) - 1;
    const visited = new Set();
    const queue = [[startX, startY, 0, 0]];
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    while (queue.length > 0) {
        const [x, y, keys, steps] = queue.shift();

        if (keys === targetKeys) {
            return steps;
        }

        const key = `${x},${y},${keys}`;
        if (visited.has(key)) {
            continue;
        }
        visited.add(key);

        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] !== '#') {
                const cell = grid[nx][ny];

                if (cell === '.' || cell === '@') {
                    queue.push([nx, ny, keys, steps + 1]);
                } else if (cell >= 'a' && cell <= 'f') {
                    const newKeys = keys | (1 << (cell.charCodeAt(0) - 'a'.charCodeAt(0)));
                    queue.push([nx, ny, newKeys, steps + 1]);
                } else if (cell >= 'A' && cell <= 'F') {
                    const neededKey = 1 << (cell.charCodeAt(0) - 'A'.charCodeAt(0));
                    if (keys & neededKey) {
                        queue.push([nx, ny, keys, steps + 1]);
                    }
                }
            }
        }
    }

    return -1;
};