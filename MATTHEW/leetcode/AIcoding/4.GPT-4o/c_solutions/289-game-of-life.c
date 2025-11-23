void gameOfLife(int** board, int boardSize, int* boardColSize) {
    int directions[8][2] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};
    int rows = boardSize, cols = *boardColSize;
    int** newBoard = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        newBoard[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int liveNeighbors = 0;
            for (int d = 0; d < 8; d++) {
                int ni = i + directions[d][0];
                int nj = j + directions[d][1];
                if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && board[ni][nj] == 1) {
                    liveNeighbors++;
                }
            }
            if (board[i][j] == 1) {
                newBoard[i][j] = (liveNeighbors == 2 || liveNeighbors == 3) ? 1 : 0;
            } else {
                newBoard[i][j] = (liveNeighbors == 3) ? 1 : 0;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            board[i][j] = newBoard[i][j];
        }
        free(newBoard[i]);
    }
    free(newBoard);
}