var minFlips = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1], [0, 0]];

    const flip = (i, j, grid) => {
        for (const [dx, dy] of dirs) {
            const x = i + dx;
            const y = j + dy;
            if (x >= 0 && x < m && y >= 0 && y < n) {
                grid[x][y] ^= 1;
            }
        }
    };

    const getHash = (grid) => {
        let hash = 0;
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                hash = hash * 2 + grid[i][j];
            }
        }
        return hash;
    };

    const initial = mat.map(row => [...row]);
    const target = Array(m).fill().map(() => Array(n).fill(0));

    const queue = [{ grid: initial, steps: 0 }];
    const visited = new Set([getHash(initial)]);

    while (queue.length > 0) {
        const { grid, steps } = queue.shift();

        if (getHash(grid) === getHash(target)) {
            return steps;
        }

        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                const newGrid = grid.map(row => [...row]);
                flip(i, j, newGrid);
                const hash = getHash(newGrid);
                if (!visited.has(hash)) {
                    visited.add(hash);
                    queue.push({ grid: newGrid, steps: steps + 1 });
                }
            }
        }
    }

    return -1;
};