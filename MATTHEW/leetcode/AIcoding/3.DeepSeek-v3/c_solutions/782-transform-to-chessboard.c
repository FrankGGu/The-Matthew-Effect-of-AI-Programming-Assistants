int movesToChessboard(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (board[0][0] ^ board[i][0] ^ board[0][j] ^ board[i][j]) {
                return -1;
            }
        }
    }

    int rowSum = 0, colSum = 0, rowDiff = 0, colDiff = 0;

    for (int i = 0; i < n; i++) {
        rowSum += board[0][i];
        colSum += board[i][0];
        rowDiff += (board[i][0] == i % 2);
        colDiff += (board[0][i] == i % 2);
    }

    if (rowSum != n / 2 && rowSum != (n + 1) / 2) return -1;
    if (colSum != n / 2 && colSum != (n + 1) / 2) return -1;

    if (n % 2) {
        if (rowSum * 2 < n) rowDiff = n - rowDiff;
        if (colSum * 2 < n) colDiff = n - colDiff;
    } else {
        rowDiff = (rowDiff < n - rowDiff) ? rowDiff : n - rowDiff;
        colDiff = (colDiff < n - colDiff) ? colDiff : n - colDiff;
    }

    return (rowDiff + colDiff) / 2;
}