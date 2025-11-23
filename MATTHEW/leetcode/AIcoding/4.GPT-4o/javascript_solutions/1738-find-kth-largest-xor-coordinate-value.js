var kthLargestValue = function(matrix, k) {
    const m = matrix.length, n = matrix[0].length;
    const xorMatrix = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            xorMatrix[i][j] = matrix[i - 1][j - 1] ^ xorMatrix[i - 1][j] ^ xorMatrix[i][j - 1] ^ xorMatrix[i - 1][j - 1];
        }
    }

    const values = [];
    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            values.push(xorMatrix[i][j]);
        }
    }

    values.sort((a, b) => b - a);
    return values[k - 1];
};