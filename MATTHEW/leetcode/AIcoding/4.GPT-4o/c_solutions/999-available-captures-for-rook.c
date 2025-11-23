int numRookCaptures(char** board, int boardSize, int* boardColSize) {
    int x, y;
    for (x = 0; x < boardSize; x++) {
        for (y = 0; y < *boardColSize; y++) {
            if (board[x][y] == 'R') {
                goto found;
            }
        }
    }
found:
    int captures = 0;
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    for (int i = 0; i < 4; i++) {
        int nx = x, ny = y;
        while (1) {
            nx += directions[i][0];
            ny += directions[i][1];
            if (nx < 0 || nx >= boardSize || ny < 0 || ny >= *boardColSize) break;
            if (board[nx][ny] == 'p') {
                captures++;
                break;
            }
            if (board[nx][ny] == 'B') break;
        }
    }
    return captures;
}