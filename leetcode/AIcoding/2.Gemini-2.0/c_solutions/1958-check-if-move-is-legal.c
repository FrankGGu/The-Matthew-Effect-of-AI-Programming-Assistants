#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkMove(char** board, int boardSize, int* boardColSize, int rMove, int cMove, char color) {
    int rows = boardSize;
    int cols = *boardColSize;
    char opponent = (color == 'B') ? 'W' : 'B';

    int directions[8][2] = {
        {-1, 0}, {1, 0}, {0, -1}, {0, 1},
        {-1, -1}, {-1, 1}, {1, -1}, {1, 1}
    };

    for (int i = 0; i < 8; i++) {
        int dx = directions[i][0];
        int dy = directions[i][1];
        int x = rMove + dx;
        int y = cMove + dy;
        int count = 0;

        while (x >= 0 && x < rows && y >= 0 && y < cols) {
            if (board[x][y] == opponent) {
                count++;
            } else if (board[x][y] == color) {
                if (count >= 1) {
                    return true;
                } else {
                    break;
                }
            } else {
                break;
            }
            x += dx;
            y += dy;
        }
    }
    return false;
}