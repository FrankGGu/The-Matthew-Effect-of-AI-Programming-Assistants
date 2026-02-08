#include <stdio.h>
#include <stdlib.h>

int numSubmat(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int count = 0;

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (matrix[r][c] == 1) {
                int min_width = cols;
                for (int i = r; i < rows; i++) {
                    min_width = (min_width < matrix[i][c]) ? min_width : matrix[i][c];
                    count += min_width;
                }
            }
        }
    }

    return count;
}