var makeSquare = function(matrix) {
    const n = matrix.length;
    let ans = 0;

    for (let i = 0; i < n - 1; i++) {
        for (let j = 0; j < n - 1; j++) {
            if (matrix[i][j] === matrix[i + 1][j] && matrix[i][j] === matrix[i][j + 1] && matrix[i][j] === matrix[i + 1][j + 1]) {
                ans++;
            }
        }
    }

    return ans;
};