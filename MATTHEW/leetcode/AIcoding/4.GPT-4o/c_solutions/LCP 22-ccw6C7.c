int canColor(int row, int col) {
    return (row + col) % 2;
}

bool[][] coloredCells(int n) {
    bool** board = (bool**)malloc(n * sizeof(bool*));
    for (int i = 0; i < n; i++) {
        board[i] = (bool*)malloc(n * sizeof(bool));
        for (int j = 0; j < n; j++) {
            board[i][j] = canColor(i, j);
        }
    }
    return board;
}