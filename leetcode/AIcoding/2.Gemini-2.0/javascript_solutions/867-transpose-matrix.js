var transpose = function(matrix) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    const transposed = Array(cols).fill(null).map(() => Array(rows).fill(null));

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            transposed[j][i] = matrix[i][j];
        }
    }

    return transposed;
};