var numberOfRightTriangles = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const rowCount = new Array(rows).fill(0);
    const colCount = new Array(cols).fill(0);

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                rowCount[i]++;
                colCount[j]++;
            }
        }
    }

    let result = 0;
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                result += (rowCount[i] - 1) * (colCount[j] - 1);
            }
        }
    }

    return result;
};