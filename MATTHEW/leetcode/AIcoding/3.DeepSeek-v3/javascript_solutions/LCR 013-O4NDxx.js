var NumMatrix = function(matrix) {
    if (matrix.length === 0 || matrix[0].length === 0) {
        this.dp = [];
        return;
    }
    const rows = matrix.length;
    const cols = matrix[0].length;
    this.dp = Array.from({ length: rows + 1 }, () => new Array(cols + 1).fill(0));
    for (let i = 1; i <= rows; i++) {
        for (let j = 1; j <= cols; j++) {
            this.dp[i][j] = matrix[i - 1][j - 1] + this.dp[i - 1][j] + this.dp[i][j - 1] - this.dp[i - 1][j - 1];
        }
    }
};

NumMatrix.prototype.sumRegion = function(row1, col1, row2, col2) {
    return this.dp[row2 + 1][col2 + 1] - this.dp[row1][col2 + 1] - this.dp[row2 + 1][col1] + this.dp[row1][col1];
};