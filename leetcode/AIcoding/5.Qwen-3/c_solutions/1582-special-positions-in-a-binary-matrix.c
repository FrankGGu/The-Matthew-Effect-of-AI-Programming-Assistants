#include <stdio.h>
#include <stdlib.h>

int numSpecial(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int* rowSums = (int*)malloc(rows * sizeof(int));
    int* colSums = (int*)malloc(cols * sizeof(int));

    for (int i = 0; i < rows; i++) {
        rowSums[i] = 0;
        for (int j = 0; j < cols; j++) {
            rowSums[i] += matrix[i][j];
        }
    }

    for (int j = 0; j < cols; j++) {
        colSums[j] = 0;
        for (int i = 0; i < rows; i++) {
            colSums[j] += matrix[i][j];
        }
    }

    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == 1 && rowSums[i] == 1 && colSums[j] == 1) {
                count++;
            }
        }
    }

    free(rowSums);
    free(colSums);
    return count;
}