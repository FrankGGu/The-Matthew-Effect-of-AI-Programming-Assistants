#include <limits.h> // Required for INT_MAX

static inline int min(int a, int b) {
    return (a < b) ? a : b;
}

int minFallingPathSum(int** matrix, int matrixSize, int* matrixColSize) {
    // The problem statement guarantees n == matrix.length == matrix[i].length,
    // meaning it's a square matrix. matrixColSize[i] will always be matrixSize.
    // Constraints: 1 <= n <= 100, so matrixSize will be at least 1.

    // Iterate through the matrix starting from the second row
    for (int i = 1; i < matrixSize; i++) {
        for (int j = 0; j < matrixSize; j++) {
            // Find the minimum path sum from the cells in the previous row
            // that can lead to the current cell (matrix[i][j]).

            // Start with the cell directly above
            int min_prev_row_val = matrix[i-1][j];

            // Check the top-left diagonal cell
            if (j > 0) {
                min_prev_row_val = min(min_prev_row_val, matrix[i-1][j-1]);
            }

            // Check the top-right diagonal cell
            if (j < matrixSize - 1) {
                min_prev_row_val = min(min_prev_row_val, matrix[i-1][j+1]);
            }

            // Update the current cell's value with the minimum falling path sum to reach it
            matrix[i][j] += min_prev_row_val;
        }
    }

    // After the loops, the last row of the matrix contains the minimum falling path sums
    // to each cell in that row. The overall minimum falling path sum is the minimum
    // value in this last row.
    int overall_min_sum = INT_MAX;
    for (int j = 0; j < matrixSize; j++) {
        overall_min_sum = min(overall_min_sum, matrix[matrixSize - 1][j]);
    }

    return overall_min_sum;
}