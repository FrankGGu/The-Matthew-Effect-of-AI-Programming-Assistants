char* tictactoe(char** moves, int movesSize) {
    int board[3][3] = {0};
    for (int i = 0; i < movesSize; i++) {
        int row = moves[i][0] - '0';
        int col = moves[i][2] - '0';
        board[row][col] = (i % 2 == 0) ? 1 : 2;

        if ((board[row][0] == board[row][1] && board[row][1] == board[row][2]) || 
            (board[0][col] == board[1][col] && board[1][col] == board[2][col]) || 
            (row == col && board[0][0] == board[1][1] && board[1][1] == board[2][2]) || 
            (row + col == 2 && board[0][2] == board[1][1] && board[1][1] == board[2][0])) {
            return (board[row][col] == 1) ? "A" : "B";
        }
    }
    return (movesSize == 9) ? "Draw" : "Pending";
}