var NumMatrix = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        this.dp = [];
        return;
    }

    const m = matrix.length;
    const n = matrix[0].length;

    this.dp = Array(m + 1).fill(0).map(() => Array(n + 1).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            this.dp[i + 1][j + 1] = matrix[i][j] + this.dp[i][j + 1] + this.dp[i + 1][j] - this.dp[i][j];
        }
    }
};

NumMatrix.prototype.sumRegion = function(row1, col1, row2, col2) {
    if (!this.dp || this.dp.length === 0) {
        return 0;
    }

    return this.dp[row2 + 1][col2 + 1] - this.dp[row1][col2 + 1] - this.dp[row2 + 1][col1] + this.dp[row1][col1];
};