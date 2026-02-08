function firstCompleteIndex(rows, cols, mat) {
    const rowCount = new Array(rows).fill(0);
    const colCount = new Array(cols).fill(0);
    const rowIdx = new Array(rows).fill(-1);
    const colIdx = new Array(cols).fill(-1);
    const totalCells = rows * cols;
    let paintedCells = 0;

    for (let i = 0; i < mat.length; i++) {
        const [x, y] = mat[i];
        rowCount[x]++;
        colCount[y]++;
        rowIdx[x] = i;
        colIdx[y] = i;
        paintedCells++;

        if (rowCount[x] === cols || colCount[y] === rows) {
            return i;
        }
    }

    return -1;
}