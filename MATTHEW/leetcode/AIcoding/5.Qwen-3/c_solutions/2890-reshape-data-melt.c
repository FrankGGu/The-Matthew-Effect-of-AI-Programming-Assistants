#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** melt(int** df, int dfSize, int* dfColSize, int* returnSize, int** returnColumnSizes) {
    int rows = dfSize;
    int cols = dfColSize[0];
    int total = rows * cols;

    int** result = (int**)malloc(total * sizeof(int*));
    *returnColumnSizes = (int*)malloc(total * sizeof(int));

    for (int i = 0; i < total; i++) {
        result[i] = (int*)malloc(sizeof(int));
        (*returnColumnSizes)[i] = 1;
    }

    int index = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result[index][0] = df[i][j];
            index++;
        }
    }

    *returnSize = total;
    return result;
}