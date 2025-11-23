var matrixReshape = function(mat, r, c) {
    const m = mat.length;
    const n = mat[0].length;

    if (m * n !== r * c) {
        return mat;
    }

    const reshapedMatrix = [];
    let currentRow = [];
    let k = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            currentRow.push(mat[i][j]);
            k++;

            if (k === c) {
                reshapedMatrix.push(currentRow);
                currentRow = [];
                k = 0;
            }
        }
    }

    return reshapedMatrix;
};