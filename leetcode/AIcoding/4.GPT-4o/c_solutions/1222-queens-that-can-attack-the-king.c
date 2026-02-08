#include <stdio.h>
#include <stdlib.h>

int** queensAttacktheKing(int** queens, int queensSize, int* queensColSize, int* returnSize, int** returnColumnSizes) {
    int directions[8][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};
    int** result = (int**)malloc(sizeof(int*) * 8);
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(sizeof(int) * 8);

    int queenSet[8][8] = {0};
    for (int i = 0; i < queensSize; i++) {
        queenSet[queens[i][0]][queens[i][1]] = 1;
    }

    for (int i = 0; i < 8; i++) {
        int x = 4, y = 4;
        while (x >= 0 && x < 8 && y >= 0 && y < 8) {
            if (queenSet[x][y]) {
                result[*returnSize] = (int*)malloc(sizeof(int) * 2);
                result[*returnSize][0] = x;
                result[*returnSize][1] = y;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
                break;
            }
            x += directions[i][0];
            y += directions[i][1];
        }
    }

    return result;
}