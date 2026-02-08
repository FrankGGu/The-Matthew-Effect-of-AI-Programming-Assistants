function incrementSubmatrices(matrix, row1, col1, row2, col2) {
    const m = matrix.length, n = matrix[0].length;
    const diff = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));

    diff[row1][col1]++;
    diff[row1][col2 + 1]--;
    diff[row2 + 1][col1]--;
    diff[row2 + 1][col2 + 1]++;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            diff[i + 1][j + 1] += diff[i][j + 1] + diff[i + 1][j] - diff[i][j];
            matrix[i][j] += diff[i + 1][j + 1];
        }
    }

    return matrix;
}