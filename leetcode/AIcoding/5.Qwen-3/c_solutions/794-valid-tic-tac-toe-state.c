#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isWin(char* board, char player) {
    for (int i = 0; i < 3; i++) {
        if (board[i * 3] == player && board[i * 3 + 1] == player && board[i * 3 + 2] == player)
            return true;
        if (board[i] == player && board[i + 3] == player && board[i + 6] == player)
            return true;
    }
    if (board[0] == player && board[4] == player && board[8] == player)
        return true;
    if (board[2] == player && board[4] == player && board[6] == player)
        return true;
    return false;
}

bool validTicTacToe(char** board, int boardSize) {
    int xCount = 0, oCount = 0;
    for (int i = 0; i < 9; i++) {
        if (board[i / 3][i % 3] == 'X') xCount++;
        if (board[i / 3][i % 3] == 'O') oCount++;
    }

    bool xWin = isWin(board[0], 'X');
    bool oWin = isWin(board[0], 'O');

    if (xWin && oWin) return false;
    if (xWin && xCount != oCount + 1) return false;
    if (oWin && xCount != oCount) return false;
    if (xCount < oCount || xCount > oCount + 1) return false;

    return true;
}