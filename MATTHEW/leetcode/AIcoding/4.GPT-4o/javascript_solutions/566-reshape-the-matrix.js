var matrixReshape = function(mat, r, c) {
    const m = mat.length, n = mat[0].length;
    if (m * n !== r * c) return mat;

    const reshaped = new Array(r).fill(0).map(() => new Array(c));
    for (let i = 0; i < m * n; i++) {
        reshaped[Math.floor(i / c)][i % c] = mat[Math.floor(i / n)][i % n];
    }
    return reshaped;
};