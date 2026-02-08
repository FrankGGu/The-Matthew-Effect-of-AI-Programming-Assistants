typedef struct {
    int x;
    int y;
} Point;

bool dfs(char** grid, int gridSize, int* gridColSize, char* target, int idx, int x, int y, bool** visited) {
    if (idx == strlen(target)) return true;
    if (x < 0 || x >= gridSize || y < 0 || y >= gridColSize[0] || visited[x][y] || grid[x][y] != target[idx]) 
        return false;

    visited[x][y] = true;

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    for (int i = 0; i < 4; i++) {
        int nx = x + dx[i];
        int ny = y + dy[i];
        if (dfs(grid, gridSize, gridColSize, target, idx + 1, nx, ny, visited)) {
            visited[x][y] = false;
            return true;
        }
    }

    visited[x][y] = false;
    return false;
}

bool placeWordInCrossword(char** board, int boardSize, int* boardColSize, char* word) {
    int m = boardSize, n = boardColSize[0];
    bool** visited = (bool**)malloc(m * sizeof(bool*));
    for (int i = 0; i < m; i++) {
        visited[i] = (bool*)calloc(n, sizeof(bool));
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (board[i][j] != '#' && (board[i][j] == word[0] || board[i][j] == ' ')) {
                if (dfs(board, m, boardColSize, word, 0, i, j, visited)) {
                    for (int k = 0; k < m; k++) free(visited[k]);
                    free(visited);
                    return true;
                }
            }
        }
    }

    for (int i = 0; i < m; i++) free(visited[i]);
    free(visited);
    return false;
}