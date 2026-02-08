var modifiedMatrix = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;

    let maxInCols = new Array(n).fill(-1);

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m; i++) {
            maxInCols[j] = Math.max(maxInCols[j], matrix[i][j]);
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] === -1) {
                matrix[i][j] = maxInCols[j];
            }
        }
    }

    return matrix;
};