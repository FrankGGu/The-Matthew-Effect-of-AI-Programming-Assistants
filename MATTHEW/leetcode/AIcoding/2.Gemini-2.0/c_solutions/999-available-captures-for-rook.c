#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numRookCaptures(char** board, int boardSize, int* boardColSize){
    int rook_row, rook_col;
    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardColSize[i]; j++) {
            if (board[i][j] == 'R') {
                rook_row = i;
                rook_col = j;
                break;
            }
        }
    }

    int captures = 0;

    // Check up
    for (int i = rook_row - 1; i >= 0; i--) {
        if (board[i][rook_col] == 'p') {
            captures++;
            break;
        } else if (board[i][rook_col] == 'B') {
            break;
        }
    }

    // Check down
    for (int i = rook_row + 1; i < boardSize; i++) {
        if (board[i][rook_col] == 'p') {
            captures++;
            break;
        } else if (board[i][rook_col] == 'B') {
            break;
        }
    }

    // Check left
    for (int j = rook_col - 1; j >= 0; j--) {
        if (board[rook_row][j] == 'p') {
            captures++;
            break;
        } else if (board[rook_row][j] == 'B') {
            break;
        }
    }

    // Check right
    for (int j = rook_col + 1; j < boardColSize[0]; j++) {
        if (board[rook_row][j] == 'p') {
            captures++;
            break;
        } else if (board[rook_row][j] == 'B') {
            break;
        }
    }

    return captures;
}