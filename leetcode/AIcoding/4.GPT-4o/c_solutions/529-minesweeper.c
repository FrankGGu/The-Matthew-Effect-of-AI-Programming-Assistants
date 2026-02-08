char** updateBoard(char** board, int boardSize, int* boardColSize, int clickRow, int clickCol) {
    if (board[clickRow][clickCol] == 'M') {
        board[clickRow][clickCol] = 'X';
        return board;
    }

    int directions[8][2] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};
    int countMines = 0;

    for (int i = 0; i < 8; i++) {
        int newRow = clickRow + directions[i][0];
        int newCol = clickCol + directions[i][1];
        if (newRow >= 0 && newRow < boardSize && newCol >= 0 && newCol < *boardColSize && board[newRow][newCol] == 'M') {
            countMines++;
        }
    }

    if (countMines > 0) {
        board[clickRow][clickCol] = countMines + '0';
    } else {
        board[clickRow][clickCol] = 'B';
        for (int i = 0; i < 8; i++) {
            int newRow = clickRow + directions[i][0];
            int newCol = clickCol + directions[i][1];
            if (newRow >= 0 && newRow < boardSize && newCol >= 0 && newCol < *boardColSize && board[newRow][newCol] == 'E') {
                updateBoard(board, boardSize, boardColSize, newRow, newCol);
            }
        }
    }

    return board;
}