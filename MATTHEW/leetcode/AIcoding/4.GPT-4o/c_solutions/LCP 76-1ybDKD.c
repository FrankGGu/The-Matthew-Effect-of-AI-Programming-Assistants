bool canMove(int x1, int y1, int x2, int y2) {
    return (x1 == x2 || y1 == y2 || abs(x1 - x2) == abs(y1 - y2));
}

bool checkMove(char** chessboard, int boardSize, int* boardColSize, int x, int y) {
    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardColSize[i]; j++) {
            if (chessboard[i][j] == 'P' && canMove(x, y, i, j)) {
                return true;
            }
        }
    }
    return false;
}

bool checkMoveOnBoard(char** chessboard, int boardSize, int* boardColSize, int x, int y) {
    return checkMove(chessboard, boardSize, boardColSize, x, y);
}