class NumMatrix {
    constructor(matrix) {
        this.prefixSum = [];
        for (let i = 0; i < matrix.length; i++) {
            this.prefixSum[i] = [];
            for (let j = 0; j < matrix[0].length; j++) {
                this.prefixSum[i][j] = matrix[i][j] + (i > 0 ? this.prefixSum[i - 1][j] : 0) + (j > 0 ? this.prefixSum[i][j - 1] : 0) - (i > 0 && j > 0 ? this.prefixSum[i - 1][j - 1] : 0);
            }
        }
    }

    sumRegion(row1, col1, row2, col2) {
        return this.prefixSum[row2][col2] - (row1 > 0 ? this.prefixSum[row1 - 1][col2] : 0) - (col1 > 0 ? this.prefixSum[row2][col1 - 1] : 0) + (row1 > 0 && col1 > 0 ? this.prefixSum[row1 - 1][col1 - 1] : 0);
    }
}