#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxEqualRowsAfterFlip(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int** flipPattern = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        flipPattern[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][0] == 1) {
                flipPattern[i][j] = 1 - matrix[i][j];
            } else {
                flipPattern[i][j] = matrix[i][j];
            }
        }
    }

    int* count = (int*)calloc(rows, sizeof(int));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < rows; j++) {
            int match = 1;
            for (int k = 0; k < cols; k++) {
                if (flipPattern[i][k] != flipPattern[j][k]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                count[i]++;
            }
        }
    }

    int max = 0;
    for (int i = 0; i < rows; i++) {
        if (count[i] > max) {
            max = count[i];
        }
    }

    for (int i = 0; i < rows; i++) {
        free(flipPattern[i]);
    }
    free(flipPattern);
    free(count);

    return max;
}