function differenceOfZerosAndOnes(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const result = Array.from({ length: rows }, () => Array(cols).fill(0));

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            const rowSum = grid[i].reduce((sum, val) => sum + (val === 1 ? 1 : -1), 0);
            const colSum = grid.reduce((sum, row) => sum + (row[j] === 1 ? 1 : -1), 0);
            result[i][j] = rowSum + colSum;
        }
    }

    return result;
}