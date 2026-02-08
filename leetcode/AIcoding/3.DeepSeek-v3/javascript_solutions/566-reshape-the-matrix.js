var matrixReshape = function(mat, r, c) {
    const m = mat.length;
    const n = mat[0].length;
    if (m * n !== r * c) {
        return mat;
    }
    const flat = mat.flat();
    const result = [];
    for (let i = 0; i < r; i++) {
        result.push(flat.slice(i * c, (i + 1) * c));
    }
    return result;
};