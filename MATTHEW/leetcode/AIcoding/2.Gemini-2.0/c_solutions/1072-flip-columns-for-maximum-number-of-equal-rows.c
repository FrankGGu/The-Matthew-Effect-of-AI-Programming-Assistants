#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxEqualRowsAfterFlips(int** matrix, int matrixSize, int* matrixColSize){
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int maxCount = 0;

    for (int i = 0; i < rows; i++) {
        int count = 0;
        for (int j = 0; j < rows; j++) {
            int isEqual = 1;
            int isEqualFlipped = 1;
            for (int k = 0; k < cols; k++) {
                if (matrix[i][k] != matrix[j][k]) {
                    isEqual = 0;
                }
                if (matrix[i][k] != (1 - matrix[j][k])) {
                    isEqualFlipped = 0;
                }
            }
            if (isEqual || isEqualFlipped) {
                count++;
            }
        }
        if (count > maxCount) {
            maxCount = count;
        }
    }

    return maxCount;
}