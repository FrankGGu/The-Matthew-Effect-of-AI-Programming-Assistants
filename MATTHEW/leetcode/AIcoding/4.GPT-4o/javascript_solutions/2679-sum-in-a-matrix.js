function matrixSum(mat) {
    let sum = 0;
    const n = mat.length;
    const m = mat[0].length;

    for (let j = 0; j < m; j++) {
        let maxInColumn = 0;
        for (let i = 0; i < n; i++) {
            maxInColumn = Math.max(maxInColumn, mat[i][j]);
        }
        sum += maxInColumn;
    }

    return sum;
}