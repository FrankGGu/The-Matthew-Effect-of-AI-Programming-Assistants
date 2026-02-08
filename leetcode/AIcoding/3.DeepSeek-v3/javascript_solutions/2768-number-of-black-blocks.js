var countBlackBlocks = function(m, n, coordinates) {
    const blocks = new Map();
    const directions = [[0, 0], [0, -1], [-1, 0], [-1, -1]];

    for (const [x, y] of coordinates) {
        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && ny >= 0 && nx + 1 < m && ny + 1 < n) {
                const key = `${nx},${ny}`;
                blocks.set(key, (blocks.get(key) || 0) + 1);
            }
        }
    }

    const res = [0, 0, 0, 0, 0];
    for (const count of blocks.values()) {
        res[count]++;
    }

    const total = (m - 1) * (n - 1);
    res[0] = total - blocks.size;

    return res;
};