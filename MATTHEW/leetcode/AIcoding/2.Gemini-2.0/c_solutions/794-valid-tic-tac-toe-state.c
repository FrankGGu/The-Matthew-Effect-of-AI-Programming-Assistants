#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool validTicTacToe(char** board, int boardSize) {
    int xCount = 0, oCount = 0;
    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardSize; j++) {
            if (board[i][j] == 'X') {
                xCount++;
            } else if (board[i][j] == 'O') {
                oCount++;
            }
        }
    }

    if (oCount > xCount || xCount - oCount > 1) {
        return false;
    }

    bool xWins = false, oWins = false;
    for (int i = 0; i < boardSize; i++) {
        if (board[i][0] == 'X' && board[i][1] == 'X' && board[i][2] == 'X') {
            xWins = true;
        }
        if (board[i][0] == 'O' && board[i][1] == 'O' && board[i][2] == 'O') {
            oWins = true;
        }
        if (board[0][i] == 'X' && board[1][i] == 'X' && board[2][i] == 'X') {
            xWins = true;
        }
        if (board[0][i] == 'O' && board[1][i] == 'O' && board[2][i] == 'O') {
            oWins = true;
        }
    }

    if (board[0][0] == 'X' && board[1][1] == 'X' && board[2][2] == 'X') {
        xWins = true;
    }
    if (board[0][0] == 'O' && board[1][1] == 'O' && board[2][2] == 'O') {
        oWins = true;
    }
    if (board[0][2] == 'X' && board[1][1] == 'X' && board[2][0] == 'X') {
        xWins = true;
    }
    if (board[0][2] == 'O' && board[1][1] == 'O' && board[2][0] == 'O') {
        oWins = true;
    }

    if (xWins && oWins) {
        return false;
    }

    if (xWins && xCount == oCount) {
        return false;
    }

    if (oWins && xCount > oCount) {
        return false;
    }

    return true;
}