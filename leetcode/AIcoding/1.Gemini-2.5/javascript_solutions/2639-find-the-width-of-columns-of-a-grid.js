var findColumnWidth = function(grid) {
    const numRows = grid.length;
    const numCols = grid[0].length;
    const result = new Array(numCols).fill(0);

    for (let j = 0; j < numCols; j++) {
        let maxWidth = 0;
        for (let i = 0; i < numRows; i++) {
            const currentString = grid[i][j];
            maxWidth = Math.max(maxWidth, currentString.length);
        }
        result[j] = maxWidth;
    }

    return result;
};