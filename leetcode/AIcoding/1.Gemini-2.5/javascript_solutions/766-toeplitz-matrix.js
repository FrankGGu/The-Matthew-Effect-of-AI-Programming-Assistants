var isToeplitzMatrix = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;

    for (let r = 0; r < m - 1; r++) {
        for (let c = 0; c < n - 1; c++) {
            if (matrix[r][c] !== matrix[r + 1][c + 1]) {
                return false;
            }
        }
    }

    return true;
};