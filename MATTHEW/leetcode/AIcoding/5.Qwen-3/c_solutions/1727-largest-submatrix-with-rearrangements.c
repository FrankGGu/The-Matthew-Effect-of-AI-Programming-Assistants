#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int largestSubmatrixWithRearrangements(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == 1) {
                if (i > 0) {
                    matrix[i][j] += matrix[i-1][j];
                }
            }
        }
    }

    int maxArea = 0;
    for (int i = 0; i < rows; i++) {
        int* heights = (int*)malloc(cols * sizeof(int));
        memcpy(heights, matrix[i], cols * sizeof(int));
        qsort(heights, cols, sizeof(int), compare);

        for (int j = 0; j < cols; j++) {
            int area = heights[j] * (j + 1);
            if (area > maxArea) {
                maxArea = area;
            }
        }
        free(heights);
    }

    return maxArea;
}