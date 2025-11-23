#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int maxRowsCovered(char** matrix, int matrixSize, int* matrixColSize, int k) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int* colCount = (int*)calloc(cols, sizeof(int));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == '1') {
                colCount[j]++;
            }
        }
    }
    qsort(colCount, cols, sizeof(int), compare);
    int sum = 0;
    for (int i = 0; i < k; i++) {
        sum += colCount[i];
    }
    free(colCount);
    return sum;
}