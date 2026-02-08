var rangeAddQueries = function(n, queries) {
    const matrix = Array.from({ length: n }, () => new Array(n).fill(0));

    for (const [row1, col1, row2, col2] of queries) {
        for (let i = row1; i <= row2; i++) {
            matrix[i][col1]++;
            if (col2 + 1 < n) {
                matrix[i][col2 + 1]--;
            }
        }
    }

    for (let i = 0; i < n; i++) {
        for (let j = 1; j < n; j++) {
            matrix[i][j] += matrix[i][j - 1];
        }
    }

    return matrix;
};