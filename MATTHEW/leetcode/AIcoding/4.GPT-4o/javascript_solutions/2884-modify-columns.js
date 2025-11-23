function modifyColumns(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    const modifiedMatrix = Array.from({ length: m }, () => Array(n).fill(0));

    for (let j = 0; j < n; j++) {
        const column = [];
        for (let i = 0; i < m; i++) {
            column.push(matrix[i][j]);
        }
        column.sort((a, b) => a - b);
        for (let i = 0; i < m; i++) {
            modifiedMatrix[i][j] = column[i];
        }
    }

    return modifiedMatrix;
}