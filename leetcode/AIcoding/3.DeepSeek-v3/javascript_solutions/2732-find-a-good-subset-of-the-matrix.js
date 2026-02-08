var goodSubsetofBinaryMatrix = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const map = new Map();

    for (let i = 0; i < m; i++) {
        let num = 0;
        for (let j = 0; j < n; j++) {
            num |= (grid[i][j] << j);
        }
        if (num === 0) {
            return [i];
        }
        map.set(num, i);
    }

    const keys = Array.from(map.keys());
    for (let i = 0; i < keys.length; i++) {
        for (let j = i + 1; j < keys.length; j++) {
            if ((keys[i] & keys[j]) === 0) {
                const idx1 = map.get(keys[i]);
                const idx2 = map.get(keys[j]);
                return [Math.min(idx1, idx2), Math.max(idx1, idx2)].sort((a, b) => a - b);
            }
        }
    }

    return [];
};