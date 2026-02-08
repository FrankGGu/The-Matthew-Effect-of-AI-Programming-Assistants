bool validTicTacToe(char **board, int boardSize) {
    int xCount = 0, oCount = 0;
    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < 3; j++) {
            if (board[i][j] == 'X') xCount++;
            if (board[i][j] == 'O') oCount++;
        }
    }

    if (oCount > xCount || xCount > oCount + 1) return false;

    bool xWin = false, oWin = false;

    for (int i = 0; i < 3; i++) {
        if (board[i][0] == board[i][1] && board[i][1] == board[i][2]) {
            if (board[i][0] == 'X') xWin = true;
            if (board[i][0] == 'O') oWin = true;
        }
        if (board[0][i] == board[1][i] && board[1][i] == board[2][i]) {
            if (board[0][i] == 'X') xWin = true;
            if (board[0][i] == 'O') oWin = true;
        }
    }

    if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
        if (board[0][0] == 'X') xWin = true;
        if (board[0][0] == 'O') oWin = true;
    }
    if (board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
        if (board[0][2] == 'X') xWin = true;
        if (board[0][2] == 'O') oWin = true;
    }

    if (xWin && oWin) return false;
    if (xWin && xCount == oCount) return false;
    if (oWin && xCount > oCount) return false;

    return true;
}