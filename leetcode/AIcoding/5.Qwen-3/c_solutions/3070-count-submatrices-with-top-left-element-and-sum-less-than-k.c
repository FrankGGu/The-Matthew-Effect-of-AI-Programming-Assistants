#include <stdio.h>
#include <stdlib.h>

int countSubmatrices(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int rows = matrixSize;
    int cols = *matrixColSize;
    int count = 0;

    for (int r1 = 0; r1 < rows; r1++) {
        int* rowSums = (int*)calloc(cols, sizeof(int));
        for (int r2 = r1; r2 < rows; r2++) {
            for (int c = 0; c < cols; c++) {
                rowSums[c] += matrix[r2][c];
            }

            int currentSum = 0;
            for (int c = 0; c < cols; c++) {
                currentSum += rowSums[c];
                if (currentSum < k) {
                    count++;
                }
            }
        }
        free(rowSums);
    }

    return count;
}