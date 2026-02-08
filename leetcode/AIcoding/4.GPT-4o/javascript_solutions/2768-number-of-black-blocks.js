var countBlackBlocks = function(m, n, coordinates) {
    const grid = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));
    const blockCount = {};

    for (const [x, y] of coordinates) {
        for (let i = Math.max(0, x - 1); i <= Math.min(m - 1, x); i++) {
            for (let j = Math.max(0, y - 1); j <= Math.min(n - 1, y); j++) {
                const key = `${i},${j}`;
                blockCount[key] = (blockCount[key] || 0) + 1;
            }
        }
    }

    const result = new Array(5).fill(0);
    for (const count of Object.values(blockCount)) {
        if (count <= 4) result[count]++;
    }

    return result;
};