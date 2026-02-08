#include <stdbool.h>
#include <string.h>

bool checkWin(char player, char board[3][3]) {
    for (int i = 0; i < 3; i++) {
        if (board[i][0] == player && board[i][1] == player && board[i][2] == player) return true;
        if (board[0][i] == player && board[1][i] == player && board[2][i] == player) return true;
    }
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) return true;
    if (board[0][2] == player && board[1][1] == player && board[2][0] == player) return true;
    return false;
}

bool isValidTicTacToeState(char** board, int boardSize) {
    char gameBoard[3][3];
    int xCount = 0;
    int oCount = 0;

    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            gameBoard[i][j] = board[i][j];
            if (board[i][j] == 'X') {
                xCount++;
            } else if (board[i][j] == 'O') {
                oCount++;
            }
        }
    }

    if (oCount > xCount || xCount > oCount + 1) {
        return false;
    }

    bool xWins = checkWin('X', gameBoard);
    bool oWins = checkWin('O', gameBoard);

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