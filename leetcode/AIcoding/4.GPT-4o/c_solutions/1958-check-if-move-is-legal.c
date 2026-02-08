bool checkMove(char** board, int row, int col, char player) {
    int n = 3;
    board[row][col] = player;

    // Check row
    for (int j = 0; j < n; j++) {
        if (board[row][j] != player) {
            goto checkCol;
        }
    }
    return true;

checkCol:
    // Check column
    for (int i = 0; i < n; i++) {
        if (board[i][col] != player) {
            goto checkDiagonal;
        }
    }
    return true;

checkDiagonal:
    // Check main diagonal
    if (row == col) {
        for (int i = 0; i < n; i++) {
            if (board[i][i] != player) {
                goto checkAntiDiagonal;
            }
        }
        return true;
    }

checkAntiDiagonal:
    // Check anti diagonal
    if (row + col == n - 1) {
        for (int i = 0; i < n; i++) {
            if (board[i][n - 1 - i] != player) {
                board[row][col] = ' '; // Reset the move
                return false;
            }
        }
        return true;
    }

    board[row][col] = ' '; // Reset the move
    return false;
}