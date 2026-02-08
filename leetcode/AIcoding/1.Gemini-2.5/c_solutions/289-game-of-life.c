void gameOfLife(int** board, int boardSize, int* boardColSize) {
    int m = boardSize;
    if (m == 0) {
        return;
    }
    int n = boardColSize[0];
    if (n == 0) {
        return;
    }

    int directions[8][2] = {
        {-1, -1}, {-1, 0}, {-1, 1},
        {0, -1},           {0, 1},
        {1, -1}, {1, 0}, {1, 1}
    };

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int liveNeighbors = 0;

            for (int k = 0; k < 8; k++) {
                int r = i + directions[k][0];
                int c = j + directions[k][1];

                if (r >= 0 && r < m && c >= 0 && c < n) {
                    if (board[r][c] == 1 || board[r][c] == 2) {
                        liveNeighbors++;
                    }
                }
            }

            if (board[i][j] == 1) { // Current cell is live
                if (liveNeighbors < 2 || liveNeighbors > 3) {
                    board[i][j] = 2; // Live cell dies (1 -> 0)
                }
            } else { // Current cell is dead (0)
                if (liveNeighbors == 3) {
                    board[i][j] = 3; // Dead cell becomes live (0 -> 1)
                }
            }
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (board[i][j] == 2) {
                board[i][j] = 0;
            } else if (board[i][j] == 3) {
                board[i][j] = 1;
            }
        }
    }
}