var maxIncreaseKeepingSkyline = function(grid) {
    const n = grid.length;
    const maxRow = new Array(n).fill(0);
    const maxCol = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            maxRow[i] = Math.max(maxRow[i], grid[i][j]);
            maxCol[j] = Math.max(maxCol[j], grid[i][j]);
        }
    }

    let totalIncrease = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            totalIncrease += Math.min(maxRow[i], maxCol[j]) - grid[i][j];
        }
    }

    return totalIncrease;
};