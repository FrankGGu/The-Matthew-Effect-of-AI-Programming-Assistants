/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return arrays are stored in *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */

int dirs[8][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}};

int check(char** board, int boardSize, int* boardColSize, int x, int y, int dx, int dy) {
    int nx = x + dx, ny = y + dy;
    if (nx < 0 || nx >= boardSize || ny < 0 || ny >= boardColSize[0] || board[nx][ny] != 'O') {
        return 0;
    }
    while (nx >= 0 && nx < boardSize && ny >= 0 && ny < boardColSize[0] && board[nx][ny] == 'O') {
        nx += dx;
        ny += dy;
    }
    if (nx < 0 || nx >= boardSize || ny < 0 || ny >= boardColSize[0] || board[nx][ny] != 'X') {
        return 0;
    }
    return 1;
}

void flip(char** board, int boardSize, int* boardColSize, int x, int y, int dx, int dy) {
    int nx = x + dx, ny = y + dy;
    while (nx >= 0 && nx < boardSize && ny >= 0 && ny < boardColSize[0] && board[nx][ny] == 'O') {
        board[nx][ny] = 'X';
        nx += dx;
        ny += dy;
    }
}

void solve(char** board, int boardSize, int* boardColSize) {
    if (boardSize == 0) return;

    for (int i = 0; i < boardSize; i++) {
        if (board[i][0] == 'O') {
            board[i][0] = 'E';
        }
        if (board[i][boardColSize[0] - 1] == 'O') {
            board[i][boardColSize[0] - 1] = 'E';
        }
    }

    for (int j = 0; j < boardColSize[0]; j++) {
        if (board[0][j] == 'O') {
            board[0][j] = 'E';
        }
        if (board[boardSize - 1][j] == 'O') {
            board[boardSize - 1][j] = 'E';
        }
    }

    int changed = 1;
    while (changed) {
        changed = 0;
        for (int i = 1; i < boardSize - 1; i++) {
            for (int j = 1; j < boardColSize[0] - 1; j++) {
                if (board[i][j] == 'O') {
                    for (int k = 0; k < 8; k++) {
                        int dx = dirs[k][0], dy = dirs[k][1];
                        int ni = i + dx, nj = j + dy;
                        if (ni >= 0 && ni < boardSize && nj >= 0 && nj < boardColSize[0] && board[ni][nj] == 'E') {
                            board[i][j] = 'E';
                            changed = 1;
                            break;
                        }
                    }
                }
            }
        }
    }

    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardColSize[0]; j++) {
            if (board[i][j] == 'O') {
                board[i][j] = 'X';
            } else if (board[i][j] == 'E') {
                board[i][j] = 'O';
            }
        }
    }
}