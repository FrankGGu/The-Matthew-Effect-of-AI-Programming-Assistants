#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** spiralMatrixIII(int rows, int cols, int rStart, int cStart, int maxMoves, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(maxMoves * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxMoves * sizeof(int));
    *returnSize = 0;

    int dx = 0, dy = 1;
    int len = 1;
    int steps = 0;

    while (*returnSize < maxMoves) {
        for (int i = 0; i < len; i++) {
            if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = rStart;
                result[*returnSize][1] = cStart;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            }
            rStart += dx;
            cStart += dy;
            if (*returnSize == maxMoves) break;
        }

        int temp = dx;
        dx = dy;
        dy = -temp;
        steps++;

        if (steps % 2 == 0) {
            len++;
        }
    }

    return result;
}