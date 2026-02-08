var snakeInMatrix = function(matrix) {
    const result = [];
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return result;
    }

    const m = matrix.length;
    const n = matrix[0].length;

    for (let i = 0; i < m; i++) {
        if (i % 2 === 0) {
            for (let j = 0; j < n; j++) {
                result.push(matrix[i][j]);
            }
        } else {
            for (let j = n - 1; j >= 0; j--) {
                result.push(matrix[i][j]);
            }
        }
    }

    return result;
};