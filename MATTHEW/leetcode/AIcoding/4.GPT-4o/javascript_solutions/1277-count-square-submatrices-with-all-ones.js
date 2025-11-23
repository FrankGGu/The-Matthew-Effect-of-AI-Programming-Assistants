var countSquares = function(matrix) {
    const m = matrix.length, n = matrix[0].length;
    let count = 0;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] === '1') {
                dp[i][j] = (i === 0 || j === 0) ? 1 : Math.min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]) + 1;
                count += dp[i][j];
            }
        }
    }

    return count;
};