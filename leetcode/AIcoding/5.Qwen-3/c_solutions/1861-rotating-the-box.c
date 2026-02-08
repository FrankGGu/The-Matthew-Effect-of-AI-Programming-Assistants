#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** rotateTheBox(char** box, int boxSize, int* boxColSize, int* returnSize, int** returnColumnSizes) {
    int rows = boxSize;
    int cols = boxColSize[0];
    char** result = (char**)malloc(rows * sizeof(char*));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        result[i] = (char*)malloc(cols * sizeof(char));
        (*returnColumnSizes)[i] = cols;
    }
    *returnSize = cols;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result[j][rows - 1 - i] = box[i][j];
        }
    }

    return result;
}