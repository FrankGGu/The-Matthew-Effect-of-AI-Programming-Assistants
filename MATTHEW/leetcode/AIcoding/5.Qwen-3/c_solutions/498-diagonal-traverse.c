#include <stdio.h>
#include <stdlib.h>

int* findDiagonalOrder(int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    if (matrixSize == 0 || *matrixColSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int rows = matrixSize;
    int cols = *matrixColSize;
    int* result = (int*)malloc(rows * cols * sizeof(int));
    int index = 0;

    for (int i = 0; i < rows + cols - 1; i++) {
        if (i % 2 == 0) {
            int r = i < rows ? i : rows - 1;
            int c = i < rows ? 0 : i - rows + 1;
            while (r >= 0 && c < cols) {
                result[index++] = matrix[r][c];
                r--;
                c++;
            }
        } else {
            int c = i < cols ? i : cols - 1;
            int r = i < cols ? 0 : i - cols + 1;
            while (r < rows && c >= 0) {
                result[index++] = matrix[r][c];
                r++;
                c--;
            }
        }
    }

    *returnSize = rows * cols;
    return result;
}