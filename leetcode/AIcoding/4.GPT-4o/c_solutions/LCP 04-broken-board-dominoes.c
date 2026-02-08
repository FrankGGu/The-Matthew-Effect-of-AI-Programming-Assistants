int dominoes(int** board, int boardSize, int* boardColSize) {
    int n = boardSize, m = boardColSize[0];
    int count = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (board[i][j] == 1) {
                count++;
                board[i][j] = 0;
                if (j + 1 < m && board[i][j + 1] == 1) {
                    board[i][j + 1] = 0;
                } else if (i + 1 < n && board[i + 1][j] == 1) {
                    board[i + 1][j] = 0;
                }
            }
        }
    }

    return count;
}