var kthLargestValue = function(matrix, k) {
    const m = matrix.length;
    const n = matrix[0].length;
    const xor = Array(m).fill().map(() => Array(n).fill(0));
    const result = [];

    xor[0][0] = matrix[0][0];
    result.push(xor[0][0]);

    for (let i = 1; i < m; i++) {
        xor[i][0] = xor[i - 1][0] ^ matrix[i][0];
        result.push(xor[i][0]);
    }

    for (let j = 1; j < n; j++) {
        xor[0][j] = xor[0][j - 1] ^ matrix[0][j];
        result.push(xor[0][j]);
    }

    for (let i = 1; i < m; i++) {
        for (let j = 1; j < n; j++) {
            xor[i][j] = xor[i - 1][j] ^ xor[i][j - 1] ^ xor[i - 1][j - 1] ^ matrix[i][j];
            result.push(xor[i][j]);
        }
    }

    result.sort((a, b) => b - a);
    return result[k - 1];
};