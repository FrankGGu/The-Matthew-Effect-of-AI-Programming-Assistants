var isPrintable = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const colorSet = new Set();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            colorSet.add(grid[i][j]);
        }
    }

    const colorToRegion = {};

    for (const color of colorSet) {
        let minRow = m, maxRow = -1, minCol = n, maxCol = -1;

        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (grid[i][j] === color) {
                    minRow = Math.min(minRow, i);
                    maxRow = Math.max(maxRow, i);
                    minCol = Math.min(minCol, j);
                    maxCol = Math.max(maxCol, j);
                }
            }
        }

        colorToRegion[color] = { minRow, maxRow, minCol, maxCol };
    }

    for (const color of colorSet) {
        const { minRow, maxRow, minCol, maxCol } = colorToRegion[color];

        for (let i = minRow; i <= maxRow; i++) {
            for (let j = minCol; j <= maxCol; j++) {
                if (grid[i][j] !== color) {
                    return false;
                }
            }
        }
    }

    return true;
};