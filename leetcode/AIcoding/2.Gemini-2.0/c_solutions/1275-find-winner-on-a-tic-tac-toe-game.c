#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char tictactoe(int** moves, int movesSize, int* movesColSize) {
    int board[3][3] = {0};
    for (int i = 0; i < movesSize; i++) {
        int row = moves[i][0];
        int col = moves[i][1];
        board[row][col] = (i % 2 == 0) ? 1 : 2;
    }
    for (int i = 0; i < 3; i++) {
        if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != 0) {
            return (board[i][0] == 1) ? 'A' : 'B';
        }
        if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != 0) {
            return (board[0][i] == 1) ? 'A' : 'B';
        }
    }
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != 0) {
        return (board[0][0] == 1) ? 'A' : 'B';
    }
    if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != 0) {
        return (board[0][2] == 1) ? 'A' : 'B';
    }
    if (movesSize == 9) {
        return "Draw"[0];
    } else {
        return "Pending"[0];
    }
}