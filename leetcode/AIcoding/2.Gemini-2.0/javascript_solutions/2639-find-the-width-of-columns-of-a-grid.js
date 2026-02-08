var findColumnWidth = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const result = new Array(n).fill(0);

    for (let j = 0; j < n; j++) {
        let maxWidth = 0;
        for (let i = 0; i < m; i++) {
            maxWidth = Math.max(maxWidth, String(grid[i][j]).length);
        }
        result[j] = maxWidth;
    }

    return result;
};