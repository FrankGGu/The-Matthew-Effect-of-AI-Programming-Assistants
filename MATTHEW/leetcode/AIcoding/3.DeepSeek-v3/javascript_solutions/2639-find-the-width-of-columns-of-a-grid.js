var findColumnWidth = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const result = new Array(n).fill(0);

    for (let j = 0; j < n; j++) {
        let maxLen = 0;
        for (let i = 0; i < m; i++) {
            const len = String(grid[i][j]).length;
            if (len > maxLen) {
                maxLen = len;
            }
        }
        result[j] = maxLen;
    }

    return result;
};