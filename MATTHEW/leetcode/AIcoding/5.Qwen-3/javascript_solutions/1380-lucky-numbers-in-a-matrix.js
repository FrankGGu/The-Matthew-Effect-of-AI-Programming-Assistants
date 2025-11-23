function luckyNumbers(matrix) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    const minInRows = new Array(rows).fill(0);
    const maxInCols = new Array(cols).fill(0);

    for (let i = 0; i < rows; i++) {
        let minVal = Infinity;
        for (let j = 0; j < cols; j++) {
            if (matrix[i][j] < minVal) {
                minVal = matrix[i][j];
            }
        }
        minInRows[i] = minVal;
    }

    for (let j = 0; j < cols; j++) {
        let maxVal = -Infinity;
        for (let i = 0; i < rows; i++) {
            if (matrix[i][j] > maxVal) {
                maxVal = matrix[i][j];
            }
        }
        maxInCols[j] = maxVal;
    }

    const result = [];
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (matrix[i][j] === minInRows[i] && matrix[i][j] === maxInCols[j]) {
                result.push(matrix[i][j]);
            }
        }
    }

    return result;
}