#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int** diagonalSort(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int rows = matrixSize;
    int cols = matrixColSize[0];

    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        int r = i, c = 0;
        int* diag = (int*)malloc((rows + cols) * sizeof(int));
        int idx = 0;
        while (r < rows && c < cols) {
            diag[idx++] = matrix[r][c];
            r++;
            c++;
        }
        qsort(diag, idx, sizeof(int), compare);
        r = i, c = 0, idx = 0;
        while (r < rows && c < cols) {
            result[r][c] = diag[idx++];
            r++;
            c++;
        }
        free(diag);
    }

    for (int j = 1; j < cols; j++) {
        int r = 0, c = j;
        int* diag = (int*)malloc((rows + cols) * sizeof(int));
        int idx = 0;
        while (r < rows && c < cols) {
            diag[idx++] = matrix[r][c];
            r++;
            c++;
        }
        qsort(diag, idx, sizeof(int), compare);
        r = 0, c = j, idx = 0;
        while (r < rows && c < cols) {
            result[r][c] = diag[idx++];
            r++;
            c++;
        }
        free(diag);
    }

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    return result;
}