bool checkMove(char** board, int boardSize, int* boardColSize, int rMove, int cMove, char color) {
    int directions[8][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}, {1,1}, {1,-1}, {-1,1}, {-1,-1}};

    for (int i = 0; i < 8; i++) {
        int dx = directions[i][0];
        int dy = directions[i][1];

        int x = rMove + dx;
        int y = cMove + dy;
        int length = 1;

        while (x >= 0 && x < boardSize && y >= 0 && y < *boardColSize) {
            length++;
            if (board[x][y] == '.') break;
            if (board[x][y] == color) {
                if (length >= 3) return true;
                else break;
            }
            x += dx;
            y += dy;
        }
    }

    return false;
}