#include <stdio.h>
#include <stdlib.h>

int** queensAttacktheKing(int** queens, int queensSize, int* queensColSize, int* king, int kingSize, int* returnSize) {
    int directions[8][2] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};
    int** result = (int**)malloc(sizeof(int*) * queensSize);
    *returnSize = 0;

    int kx = king[0], ky = king[1];

    for (int i = 0; i < queensSize; i++) {
        int qx = queens[i][0], qy = queens[i][1];
        int dx = qx - kx, dy = qy - ky;
        int steps = 0;

        if (dx == 0 || dy == 0 || abs(dx) == abs(dy)) {
            int dirX = (dx == 0) ? 0 : (dx > 0 ? 1 : -1);
            int dirY = (dy == 0) ? 0 : (dy > 0 ? 1 : -1);

            int x = qx + dirX, y = qy + dirY;
            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                if (x == kx && y == ky) {
                    result[*returnSize] = (int*)malloc(sizeof(int) * 4);
                    result[*returnSize][0] = qx;
                    result[*returnSize][1] = qy;
                    result[*returnSize][2] = kx;
                    result[*returnSize][3] = ky;
                    (*returnSize)++;
                    break;
                }
                x += dirX;
                y += dirY;
            }
        }
    }

    return result;
}