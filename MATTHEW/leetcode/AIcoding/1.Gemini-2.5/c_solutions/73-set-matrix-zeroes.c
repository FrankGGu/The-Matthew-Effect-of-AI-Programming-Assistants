#include <stdbool.h> // Required for bool type

void setZeroes(int** matrix, int matrixSize, int* matrixColSize) {
    int m = matrixSize;
    if (m == 0) return;
    int n = matrixColSize[0];
    if (n == 0) return;

    bool col0_has_zero = false;

    // Step 1: Determine if the first column needs to be zeroed
    // This check must be done before matrix[i][0] potentially gets overwritten
    for (int i = 0; i < m; i++) {
        if (matrix[i][0] == 0) {
            col0_has_zero = true;
            break;
        }
    }

    // Step 2: Use the first row and first column as markers for the rest of the matrix.
    // matrix[i][0] will mark if row i needs to be zeroed (for i > 0).
    // matrix[0][j] will mark if column j needs to be zeroed (for j > 0).
    // matrix[0][0] will be used to mark if row 0 needs to be zeroed.
    // col0_has_zero flag handles if column 0 needs to be zeroed.
    for (int i = 0; i < m; i++) {
        for (int j = 1; j < n; j++) { // Iterate j from 1 to n-1
            if (matrix[i][j] == 0) {
                matrix[i][0] = 0; // Mark row i
                matrix[0][j] = 0; // Mark column j
            }
        }
    }

    // Step 3: Zero out rows and columns based on markers (excluding the first column for now).
    // Iterate from bottom-right to top-left to avoid using modified cells as markers.
    for (int i = m - 1; i >= 0; i--) {
        for (int j = n - 1; j >= 1; j--) { // Iterate j from n-1 down to 1
            if (matrix[i][0] == 0 || matrix[0][j] == 0) {
                matrix[i][j] = 0;
            }
        }
    }

    // Step 4: Handle the first column based on the col0_has_zero flag.
    // This must be done last to ensure matrix[0][0] is used correctly as a marker for row 0.
    if (col0_has_zero) {
        for (int i = 0; i < m; i++) {
            matrix[i][0] = 0;
        }
    }
}