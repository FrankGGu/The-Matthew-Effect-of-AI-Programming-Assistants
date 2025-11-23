var matrixReshape = function(mat, r, c) {
    const m = mat.length;
    const n = mat[0].length;

    if (m * n !== r * c) {
        return mat;
    }

    const flatArray = [];
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            flatArray.push(mat[i][j]);
        }
    }

    const reshapedMat = [];
    let k = 0;
    for (let i = 0; i < r; i++) {
        const newRow = [];
        for (let j = 0; j < c; j++) {
            newRow.push(flatArray[k++]);
        }
        reshapedMat.push(newRow);
    }

    return reshapedMat;
};