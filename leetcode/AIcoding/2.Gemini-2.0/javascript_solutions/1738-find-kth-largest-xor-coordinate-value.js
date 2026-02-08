var kthLargestValue = function(matrix, k) {
    const m = matrix.length;
    const n = matrix[0].length;
    const xorMatrix = Array(m).fill(null).map(() => Array(n).fill(0));
    const results = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 && j === 0) {
                xorMatrix[i][j] = matrix[i][j];
            } else if (i === 0) {
                xorMatrix[i][j] = xorMatrix[i][j - 1] ^ matrix[i][j];
            } else if (j === 0) {
                xorMatrix[i][j] = xorMatrix[i - 1][j] ^ matrix[i][j];
            } else {
                xorMatrix[i][j] = xorMatrix[i - 1][j] ^ xorMatrix[i][j - 1] ^ xorMatrix[i - 1][j - 1] ^ matrix[i][j];
            }
            results.push(xorMatrix[i][j]);
        }
    }

    results.sort((a, b) => b - a);
    return results[k - 1];
};