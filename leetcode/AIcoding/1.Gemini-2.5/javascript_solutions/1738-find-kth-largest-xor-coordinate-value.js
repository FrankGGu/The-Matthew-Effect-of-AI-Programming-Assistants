var kthLargestValue = function(matrix, k) {
    const m = matrix.length;
    const n = matrix[0].length;

    const xorCoords = [];
    const dp = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let currentVal = matrix[i][j];

            if (i > 0) {
                currentVal ^= dp[i - 1][j];
            }
            if (j > 0) {
                currentVal ^= dp[i][j - 1];
            }
            if (i > 0 && j > 0) {
                currentVal ^= dp[i - 1][j - 1];
            }

            dp[i][j] = currentVal;
            xorCoords.push(currentVal);
        }
    }

    xorCoords.sort((a, b) => b - a);

    return xorCoords[k - 1];
};