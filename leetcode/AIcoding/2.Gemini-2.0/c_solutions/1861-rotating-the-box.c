#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** rotateTheBox(char** box, int boxSize, int* boxColSize, int* returnSize, int** returnColumnSizes) {
    int n = boxSize;
    int m = boxColSize[0];

    char** rotatedBox = (char**)malloc(sizeof(char*) * m);
    *returnSize = m;
    *returnColumnSizes = (int*)malloc(sizeof(int) * m);

    for (int i = 0; i < m; i++) {
        rotatedBox[i] = (char*)malloc(sizeof(char) * n);
        (*returnColumnSizes)[i] = n;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            rotatedBox[i][j] = box[n - 1 - j][i];
        }
    }

    for (int i = 0; i < m; i++) {
        int bottom = n - 1;
        for (int j = n - 1; j >= 0; j--) {
            if (rotatedBox[i][j] == '*') {
                bottom = j - 1;
            } else if (rotatedBox[i][j] == '#') {
                rotatedBox[i][j] = '.';
                rotatedBox[i][bottom] = '#';
                bottom--;
            }
        }
    }

    return rotatedBox;
}