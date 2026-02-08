int numRookCaptures(char** board, int boardSize, int* boardColSize) {
    int rx, ry;
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (board[i][j] == 'R') {
                rx = i;
                ry = j;
                break;
            }
        }
    }

    int count = 0;
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};

    for (int i = 0; i < 4; i++) {
        int x = rx + dx[i];
        int y = ry + dy[i];
        while (x >= 0 && x < 8 && y >= 0 && y < 8) {
            if (board[x][y] == 'p') {
                count++;
                break;
            } else if (board[x][y] == 'B') {
                break;
            }
            x += dx[i];
            y += dy[i];
        }
    }

    return count;
}