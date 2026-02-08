var transpose = function(matrix) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    const transposed = [];
    for (let j = 0; j < cols; j++) {
        const newRow = [];
        for (let i = 0; i < rows; i++) {
            newRow.push(matrix[i][j]);
        }
        transposed.push(newRow);
    }
    return transposed;
};