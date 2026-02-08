var shortestPathAllKeys = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let startRow, startCol;
    let maxKeys = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === '@') {
                startRow = i;
                startCol = j;
            } else if (/[a-f]/.test(grid[i][j])) {
                maxKeys = Math.max(maxKeys, grid[i][j].charCodeAt(0) - 'a'.charCodeAt(0) + 1);
            }
        }
    }

    const queue = [[startRow, startCol, 0, 0]];
    const visited = new Set();
    visited.add(`${startRow},${startCol},0`);

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    let steps = 0;
    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const [row, col, keys, dist] = queue.shift();

            if (keys === (1 << maxKeys) - 1) {
                return steps;
            }

            for (const [dr, dc] of directions) {
                const newRow = row + dr;
                const newCol = col + dc;

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && grid[newRow][newCol] !== '#') {
                    const cell = grid[newRow][newCol];
                    let newKeys = keys;

                    if (/[a-f]/.test(cell)) {
                        const keyIndex = cell.charCodeAt(0) - 'a'.charCodeAt(0);
                        newKeys |= (1 << keyIndex);
                    } else if (/[A-F]/.test(cell)) {
                        const lockIndex = cell.charCodeAt(0) - 'A'.charCodeAt(0);
                        if ((keys & (1 << lockIndex)) === 0) {
                            continue;
                        }
                    }

                    const state = `${newRow},${newCol},${newKeys}`;
                    if (!visited.has(state)) {
                        visited.add(state);
                        queue.push([newRow, newCol, newKeys, dist + 1]);
                    }
                }
            }
        }
        steps++;
    }

    return -1;
};