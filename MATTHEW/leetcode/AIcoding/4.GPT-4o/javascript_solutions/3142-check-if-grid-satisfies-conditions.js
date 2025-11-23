function checkGrid(grid) {
    const n = grid.length;
    for (let i = 0; i < n; i++) {
        const rowCount = Array(n).fill(0);
        const colCount = Array(n).fill(0);
        for (let j = 0; j < n; j++) {
            rowCount[grid[i][j]]++;
            colCount[grid[j][i]]++;
        }
        for (let k = 0; k < n; k++) {
            if (rowCount[k] !== 1 || colCount[k] !== 1) {
                return false;
            }
        }
    }
    return true;
}