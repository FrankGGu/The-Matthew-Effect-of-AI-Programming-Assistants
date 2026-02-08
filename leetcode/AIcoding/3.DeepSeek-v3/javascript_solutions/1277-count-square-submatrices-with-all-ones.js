var countSquares = function(matrix) {
    if (matrix.length === 0) return 0;
    let rows = matrix.length, cols = matrix[0].length;
    let dp = Array.from({length: rows}, () => new Array(cols).fill(0));
    let count = 0;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (matrix[i][j] === 1) {
                if (i === 0 || j === 0) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = Math.min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1;
                }
                count += dp[i][j];
            }
        }
    }

    return count;
};