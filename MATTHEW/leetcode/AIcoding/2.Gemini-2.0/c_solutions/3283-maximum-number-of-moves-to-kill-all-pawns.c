#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxKilledPawns(char** board, int boardSize, int* boardColSize) {
    int rows = boardSize;
    int cols = boardColSize[0];
    int count = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (board[i][j] == 'R') {
                // Check left
                for (int k = j - 1; k >= 0; k--) {
                    if (board[i][k] == 'p') {
                        count++;
                        board[i][k] = '.';
                        break;
                    } else if (board[i][k] != '.') {
                        break;
                    }
                }

                // Check right
                for (int k = j + 1; k < cols; k++) {
                    if (board[i][k] == 'p') {
                        count++;
                        board[i][k] = '.';
                        break;
                    } else if (board[i][k] != '.') {
                        break;
                    }
                }

                // Check up
                for (int k = i - 1; k >= 0; k--) {
                    if (board[k][j] == 'p') {
                        count++;
                        board[k][j] = '.';
                        break;
                    } else if (board[k][j] != '.') {
                        break;
                    }
                }

                // Check down
                for (int k = i + 1; k < rows; k++) {
                    if (board[k][j] == 'p') {
                        count++;
                        board[k][j] = '.';
                        break;
                    } else if (board[k][j] != '.') {
                        break;
                    }
                }
            }
        }
    }

    return count;
}