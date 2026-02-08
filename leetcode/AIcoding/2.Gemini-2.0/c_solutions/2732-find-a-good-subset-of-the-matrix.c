#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool is_good(int a[], int b[], int cols) {
    for (int i = 0; i < cols; ++i) {
        if (a[i] == 1 && b[i] == 1) {
            return false;
        }
    }
    return true;
}

int* goodSubsetofBinaryMatrix(int** matrix, int matrixSize, int* matrixColSize, int* returnSize){
    int cols = matrixColSize[0];

    for (int i = 0; i < matrixSize; ++i) {
        bool all_zeros = true;
        for (int j = 0; j < cols; ++j) {
            if (matrix[i][j] == 1) {
                all_zeros = false;
                break;
            }
        }
        if (all_zeros) {
            *returnSize = 1;
            int* result = (int*)malloc(sizeof(int));
            result[0] = i;
            return result;
        }
    }

    for (int i = 0; i < matrixSize; ++i) {
        for (int j = i + 1; j < matrixSize; ++j) {
            if (is_good(matrix[i], matrix[j], cols)) {
                *returnSize = 2;
                int* result = (int*)malloc(2 * sizeof(int));
                result[0] = i;
                result[1] = j;
                return result;
            }
        }
    }

    *returnSize = 0;
    return NULL;
}