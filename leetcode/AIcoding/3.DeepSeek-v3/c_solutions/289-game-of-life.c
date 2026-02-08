void gameOfLife(int** board, int boardSize, int* boardColSize) {
    if (boardSize == 0 || boardColSize[0] == 0) return;

    int rows = boardSize;
    int cols = boardColSize[0];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int liveNeighbors = 0;

            for (int x = -1; x <= 1; x++) {
                for (int y = -1; y <= 1; y++) {
                    if (x == 0 && y == 0) continue;

                    int ni = i + x;
                    int nj = j + y;

                    if (ni >= 0 && ni < rows && nj >= 0 && nj < cols) {
                        if (board[ni][nj] == 1 || board[ni][nj] == -1) {
                            liveNeighbors++;
                        }
                    }
                }
            }

            if (board[i][j] == 1) {
                if (liveNeighbors < 2 || liveNeighbors > 3) {
                    board[i][j] = -1;
                }
            } else {
                if (liveNeighbors == 3) {
                    board[i][j] = 2;
                }
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (board[i][j] == -1) {
                board[i][j] = 0;
            } else if (board[i][j] == 2) {
                board[i][j] = 1;
            }
        }
    }
}