function diagonalSort(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const map = new Map();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const key = i - j;
            if (!map.has(key)) {
                map.set(key, []);
            }
            map.get(key).push(grid[i][j]);
        }
    }

    for (const key of map.keys()) {
        map.get(key).sort((a, b) => a - b);
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const key = i - j;
            grid[i][j] = map.get(key).shift();
        }
    }

    return grid;
}