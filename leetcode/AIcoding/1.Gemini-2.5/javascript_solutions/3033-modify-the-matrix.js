var modifyMatrix = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    const columnMax = new Array(n).fill(0);

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m; i++) {
            if (matrix[i][j] !== -1) {
                columnMax[j] = Math.max(columnMax[j], matrix[i][j]);
            }
        }
    }

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m; i++) {
            if (matrix[i][j] === -1) {
                matrix[i][j] = columnMax[j];
            }
        }
    }

    return matrix;
};