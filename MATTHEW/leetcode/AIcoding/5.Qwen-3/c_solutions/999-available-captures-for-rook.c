#include <stdio.h>
#include <stdlib.h>

int numRookMoves(char** board, int boardSize, int* boardColSize) {
    int x, y;
    for (x = 0; x < boardSize; x++) {
        for (y = 0; y < *boardColSize; y++) {
            if (board[x][y] == 'r') {
                break;
            }
        }
        if (board[x][y] == 'r') {
            break;
        }
    }

    int count = 0;

    // Up
    for (int i = x - 1; i >= 0; i--) {
        if (board[i][y] == 'p') {
            count++;
            break;
        } else if (board[i][y] == 'B') {
            break;
        }
    }

    // Down
    for (int i = x + 1; i < boardSize; i++) {
        if (board[i][y] == 'p') {
            count++;
            break;
        } else if (board[i][y] == 'B') {
            break;
        }
    }

    // Left
    for (int j = y - 1; j >= 0; j--) {
        if (board[x][j] == 'p') {
            count++;
            break;
        } else if (board[x][j] == 'B') {
            break;
        }
    }

    // Right
    for (int j = y + 1; j < *boardColSize; j++) {
        if (board[x][j] == 'p') {
            count++;
            break;
        } else if (board[x][j] == 'B') {
            break;
        }
    }

    return count;
}