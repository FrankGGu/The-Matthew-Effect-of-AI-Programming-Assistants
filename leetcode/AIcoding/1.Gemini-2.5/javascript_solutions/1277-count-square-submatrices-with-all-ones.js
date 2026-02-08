var countSquares = function(matrix) {
    let count = 0;
    const m = matrix.length;
    const n = matrix[0].length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] === 1) {
                if (i > 0 && j > 0) {
                    matrix[i][j] = 1 + Math.min(matrix[i - 1][j], matrix[i][j - 1], matrix[i - 1][j - 1]);
                }
                count += matrix[i][j];
            }
        }
    }

    return count;
};