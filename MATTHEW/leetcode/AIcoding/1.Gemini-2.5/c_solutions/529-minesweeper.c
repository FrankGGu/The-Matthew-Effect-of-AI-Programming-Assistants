int dr[] = {-1, -1, -1, 0, 0, 1, 1, 1};
int dc[] = {-1, 0, 1, -1, 1, -1, 0, 1};

void dfs(char** board, int r, int c, int numRows, int numCols) {
    if (r < 0 || r >= numRows || c < 0 || c >= numCols || board[r][c] != 'E') {
        return;
    }

    int mineCount = 0;
    for (int i = 0; i < 8; i++) {
        int nr = r + dr[i];
        int nc = c + dc[i];

        if (nr >= 0 && nr < numRows && nc >= 0 && nc < numCols && board[nr][nc] == 'M') {
            mineCount++;
        }
    }

    if (mineCount > 0) {
        board[r][c] = (char)('0' + mineCount);
    } else {
        board[r][c] = 'B';
        for (int i = 0; i < 8; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            dfs(board, nr, nc, numRows, numCols);
        }
    }
}

char** updateBoard(char** board, int boardSize, int* boardColSize, int* click, int clickSize) {
    int r = click[0];
    int c = click[1];
    int numRows = boardSize;
    int numCols = boardColSize[0];

    if (board[r][c] == 'M') {
        board[r][c] = 'X';
    } else if (board[r][c] == 'E') {
        dfs(board, r, c, numRows, numCols);
    }

    return board;
}