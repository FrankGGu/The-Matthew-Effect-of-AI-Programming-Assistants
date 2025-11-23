#include <stdio.h>
#include <stdlib.h>

int** reshapeData(int** data, int rows, int cols, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(rows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
        result[i] = (int*)malloc(cols * sizeof(int));
    }
    *returnSize = rows;
    int index = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result[i][j] = data[index / cols][index % cols];
            index++;
        }
    }
    return result;
}