#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int** getMinDifference(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result[i][j] = INT_MAX;
        }
    }

    for (int i = k; i < rows - k; i++) {
        for (int j = k; j < cols - k; j++) {
            int minVal = INT_MAX;
            int maxVal = INT_MIN;
            for (int x = i - k; x <= i + k; x++) {
                for (int y = j - k; y <= j + k; y++) {
                    if (matrix[x][y] < minVal) minVal = matrix[x][y];
                    if (matrix[x][y] > maxVal) maxVal = matrix[x][y];
                }
            }
            result[i][j] = maxVal - minVal;
        }
    }

    return result;
}