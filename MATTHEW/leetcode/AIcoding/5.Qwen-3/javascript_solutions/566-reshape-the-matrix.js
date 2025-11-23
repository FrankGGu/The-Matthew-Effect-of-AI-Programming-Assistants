function matrixReshape(mat, r, c) {
    const flat = mat.flat();
    if (flat.length !== r * c) return mat;
    const result = [];
    for (let i = 0; i < r; i++) {
        result.push(flat.slice(i * c, (i + 1) * c));
    }
    return result;
}