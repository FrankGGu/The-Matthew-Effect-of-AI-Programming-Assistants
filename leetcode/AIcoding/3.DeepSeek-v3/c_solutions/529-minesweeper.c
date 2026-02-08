/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
char** updateBoard(char** board, int boardSize, int* boardColSize, int* click, int clickSize, int* returnSize, int** returnColumnSizes) {
    int m = boardSize;
    int n = boardColSize[0];
    int r = click[0];
    int c = click[1];

    if (board[r][c] == 'M') {
        board[r][c] = 'X';
        *returnSize = m;
        *returnColumnSizes = (int*)malloc(m * sizeof(int));
        for (int i = 0; i < m; i++) {
            (*returnColumnSizes)[i] = n;
        }
        return board;
    }

    int dirs[8][2] = {{-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,1}, {1,-1}, {1,0}, {1,1}};

    void dfs(int x, int y) {
        if (x < 0 || x >= m || y < 0 || y >= n || board[x][y] != 'E') {
            return;
        }

        int mineCount = 0;
        for (int i = 0; i < 8; i++) {
            int nx = x + dirs[i][0];
            int ny = y + dirs[i][1];
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && board[nx][ny] == 'M') {
                mineCount++;
            }
        }

        if (mineCount > 0) {
            board[x][y] = '0' + mineCount;
        } else {
            board[x][y] = 'B';
            for (int i = 0; i < 8; i++) {
                int nx = x + dirs[i][0];
                int ny = y + dirs[i][1];
                dfs(nx, ny);
            }
        }
    }

    dfs(r, c);

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }
    return board;
}