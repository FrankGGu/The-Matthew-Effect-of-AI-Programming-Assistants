var shortestPathAllKeys = function(grid) {
    const m = grid.length, n = grid[0].length;
    const totalKeys = [...grid.join('')].filter(c => c >= 'a' && c <= 'f').length;
    const keyMask = (1 << totalKeys) - 1;
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    let startX, startY;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === '@') {
                startX = i;
                startY = j;
            }
        }
    }

    const queue = [[startX, startY, 0, 0]]; // [x, y, keys, steps]
    const visited = new Set();
    visited.add(`${startX},${startY},0`);

    while (queue.length) {
        const [x, y, keys, steps] = queue.shift();
        if (keys === keyMask) return steps;

        for (const [dx, dy] of directions) {
            const nx = x + dx, ny = y + dy;

            if (nx < 0 || ny < 0 || nx >= m || ny >= n) continue;
            const cell = grid[nx][ny];

            if (cell === '#') continue;

            let newKeys = keys;
            if (cell >= 'a' && cell <= 'f') {
                newKeys |= (1 << (cell.charCodeAt(0) - 'a'.charCodeAt(0)));
            } else if (cell >= 'A' && cell <= 'F') {
                if (!(keys & (1 << (cell.charCodeAt(0) - 'A'.charCodeAt(0))))) continue;
            }

            const state = `${nx},${ny},${newKeys}`;
            if (!visited.has(state)) {
                visited.add(state);
                queue.push([nx, ny, newKeys, steps + 1]);
            }
        }
    }

    return -1;
};