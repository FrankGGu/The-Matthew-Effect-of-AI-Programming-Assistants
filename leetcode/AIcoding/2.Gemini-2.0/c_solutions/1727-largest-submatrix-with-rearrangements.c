#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestSubmatrix(int** matrix, int matrixSize, int* matrixColSize){
    int n = matrixSize;
    int m = matrixColSize[0];
    int max_area = 0;

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (matrix[i][j] == 1) {
                matrix[i][j] += matrix[i - 1][j];
            }
        }
    }

    for (int i = 0; i < n; i++) {
        int* row = matrix[i];
        qsort(row, m, sizeof(int), [](const void* a, const void* b) {
            return *(int*)b - *(int*)a;
        });

        for (int j = 0; j < m; j++) {
            int area = row[j] * (j + 1);
            if (area > max_area) {
                max_area = area;
            }
        }
    }

    return max_area;
}