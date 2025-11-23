int* hitBricks(int** grid, int gridSize, int* gridColSize, int** hits, int hitsSize, int* returnSize) {
    int rows = gridSize, cols = *gridColSize;
    int* result = (int*)malloc(hitsSize * sizeof(int));
    int* directions = (int*)malloc(4 * sizeof(int));
    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)malloc(cols * sizeof(int));
        memset(visited[i], 0, cols * sizeof(int));
    }

    for (int i = 0; i < hitsSize; i++) {
        grid[hits[i][0]][hits[i][1]]--;
    }

    void dfs(int r, int c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] <= 0 || visited[r][c]) return;
        visited[r][c] = 1;
        for (int i = 0; i < 4; i++) {
            dfs(r + directions[i * 2], c + directions[i * 2 + 1]);
        }
    }

    for (int j = 0; j < cols; j++) {
        if (grid[0][j] > 0) {
            dfs(0, j);
        }
    }

    for (int i = hitsSize - 1; i >= 0; i--) {
        int r = hits[i][0], c = hits[i][1];
        if (grid[r][c] == 0) {
            grid[r][c] = 1;
            if (r == 0 || (r > 0 && visited[r - 1][c]) || (r < rows - 1 && visited[r + 1][c]) || (c > 0 && visited[r][c - 1]) || (c < cols - 1 && visited[r][c + 1])) {
                if (r == 0) result[i] = 1;
                else {
                    int count = 0;
                    dfs(r, c);
                    for (int x = 0; x < cols; x++) {
                        if (visited[0][x]) count++;
                    }
                    result[i] = count - 1;
                }
            } else {
                result[i] = 0;
            }
        } else {
            result[i] = 0;
        }
    }

    *returnSize = hitsSize;
    for (int i = 0; i < rows; i++) free(visited[i]);
    free(visited); free(directions);
    return result;
}