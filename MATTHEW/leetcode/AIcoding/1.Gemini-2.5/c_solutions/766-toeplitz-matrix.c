#include <stdbool.h>

bool isToeplitzMatrix(int** matrix, int matrixSize, int* matrixColSize) {
    int m = matrixSize;
    int n = matrixColSize[0];

    for (int r = 0; r < m - 1; r++) {
        for (int c = 0; c < n - 1; c++) {
            if (matrix[r][c] != matrix[r + 1][c + 1]) {
                return false;
            }
        }
    }

    return true;
}