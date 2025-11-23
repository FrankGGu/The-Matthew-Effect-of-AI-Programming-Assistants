bool exist(char **board, int boardSize, int* boardColSize, char * word) {
    int rows = boardSize;
    int cols = *boardColSize;
    bool visited[rows][cols];
    memset(visited, false, sizeof(visited));

    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    bool backtrack(int r, int c, int index) {
        if (index == strlen(word)) return true;
        if (r < 0 || r >= rows || c < 0 || c >= cols || visited[r][c] || board[r][c] != word[index]) return false;

        visited[r][c] = true;
        for (int i = 0; i < 4; i++) {
            if (backtrack(r + directions[i][0], c + directions[i][1], index + 1)) return true;
        }
        visited[r][c] = false;
        return false;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (backtrack(i, j, 0)) return true;
        }
    }
    return false;
}