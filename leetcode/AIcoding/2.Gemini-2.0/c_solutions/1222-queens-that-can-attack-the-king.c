#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** queensAttacktheKing(int** queens, int queensSize, int* queensColSize, int* king, int kingSize, int* returnSize, int** returnColumnSizes){
    int board[8][8] = {0};
    for (int i = 0; i < queensSize; i++) {
        board[queens[i][0]][queens[i][1]] = 1;
    }

    int** result = (int**)malloc(queensSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(queensSize * sizeof(int));
    *returnSize = 0;

    int directions[8][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}};

    for (int i = 0; i < 8; i++) {
        int dx = directions[i][0];
        int dy = directions[i][1];
        int x = king[0] + dx;
        int y = king[1] + dy;

        while (x >= 0 && x < 8 && y >= 0 && y < 8) {
            if (board[x][y] == 1) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = x;
                result[*returnSize][1] = y;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
                break;
            }
            x += dx;
            y += dy;
        }
    }

    return result;
}