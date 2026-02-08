var modifyColumns = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return;
    }

    const m = matrix.length;
    const n = matrix[0].length;

    const colsToZero = new Array(n).fill(false);

    for (let j = 0; j < n; j++) {
        if (matrix[0][j] === 0) {
            colsToZero[j] = true;
        }
    }

    for (let j = 0; j < n; j++) {
        if (colsToZero[j]) {
            for (let i = 0; i < m; i++) {
                matrix[i][j] = 0;
            }
        }
    }
};