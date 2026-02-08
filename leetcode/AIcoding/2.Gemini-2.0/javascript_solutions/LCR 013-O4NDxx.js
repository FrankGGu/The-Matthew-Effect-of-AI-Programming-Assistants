var NumMatrix = function(matrix) {
    this.matrix = matrix;
    if (matrix.length === 0 || matrix[0].length === 0) {
        this.sumMatrix = [[]];
        return;
    }

    let m = matrix.length;
    let n = matrix[0].length;
    this.sumMatrix = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            this.sumMatrix[i][j] = this.sumMatrix[i - 1][j] + this.sumMatrix[i][j - 1] - this.sumMatrix[i - 1][j - 1] + matrix[i - 1][j - 1];
        }
    }
};

NumMatrix.prototype.sumRegion = function(row1, col1, row2, col2) {
    if (this.matrix.length === 0 || this.matrix[0].length === 0) {
        return 0;
    }
    return this.sumMatrix[row2 + 1][col2 + 1] - this.sumMatrix[row1][col2 + 1] - this.sumMatrix[row2 + 1][col1] + this.sumMatrix[row1][col1];
};