#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** findGoodSubset(int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    char** result = (char**)malloc(sizeof(char*) * 2);
    result[0] = (char*)malloc(sizeof(char) * (cols + 1));
    result[1] = (char*)malloc(sizeof(char) * (cols + 1));
    for (int i = 0; i < cols; i++) {
        result[0][i] = '0';
        result[1][i] = '0';
    }
    result[0][cols] = '\0';
    result[1][cols] = '\0';

    int* colSum = (int*)calloc(cols, sizeof(int));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            colSum[j] += matrix[i][j];
        }
    }

    int* mask = (int*)malloc(sizeof(int) * rows);
    for (int i = 0; i < rows; i++) {
        mask[i] = 0;
    }

    int count = 0;
    for (int i = 0; i < rows; i++) {
        int allZero = 1;
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == 1) {
                allZero = 0;
                break;
            }
        }
        if (allZero) {
            mask[i] = 1;
            count++;
        }
    }

    for (int i = 0; i < rows; i++) {
        if (mask[i] == 1) {
            for (int j = 0; j < cols; j++) {
                if (matrix[i][j] == 1) {
                    result[0][j] = '1';
                }
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        if (mask[i] == 1) {
            for (int j = 0; j < cols; j++) {
                if (matrix[i][j] == 1) {
                    result[1][j] = '1';
                }
            }
        }
    }

    *returnSize = 2;
    return result;
}