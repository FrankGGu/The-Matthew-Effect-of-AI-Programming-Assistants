#include <stdio.h>
#include <stdlib.h>

void gameOfLife(int** board, int boardSize, int* boardColSize) {
    int m = boardSize;
    int n = boardColSize[0];

    int i, j;
    int neighbors;

    for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {
            neighbors = 0;

            for (int x = -1; x <= 1; x++) {
                for (int y = -1; y <= 1; y++) {
                    if (x == 0 && y == 0) continue;

                    int ni = i + x;
                    int nj = j + y;

                    if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                        neighbors += board[ni][nj] & 1;
                    }
                }
            }

            if (board[i][j] & 1) {
                if (neighbors == 2 || neighbors == 3) {
                    board[i][j] |= 2;
                }
            } else {
                if (neighbors == 3) {
                    board[i][j] |= 2;
                }
            }
        }
    }

    for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {
            board[i][j] >>= 1;
        }
    }
}