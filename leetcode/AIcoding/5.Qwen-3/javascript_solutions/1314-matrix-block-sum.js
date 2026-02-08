function matrixBlockSum(mat, k) {
    const m = mat.length;
    const n = mat[0].length;
    const sum = Array.from({ length: m }, () => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const row1 = Math.max(0, i - k);
            const row2 = Math.min(m - 1, i + k);
            const col1 = Math.max(0, j - k);
            const col2 = Math.min(n - 1, j + k);

            for (let x = row1; x <= row2; x++) {
                for (let y = col1; y <= col2; y++) {
                    sum[i][j] += mat[x][y];
                }
            }
        }
    }

    return sum;
}