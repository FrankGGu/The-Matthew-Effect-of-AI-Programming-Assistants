int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

int dfs(int** matrix, int matrixSize, int* matrixColSize, int** memo, int i, int j) {
    if (memo[i][j] != 0) return memo[i][j];

    int maxPath = 1;
    for (int k = 0; k < 4; k++) {
        int x = i + directions[k][0];
        int y = j + directions[k][1];

        if (x >= 0 && x < matrixSize && y >= 0 && y < matrixColSize[0] && matrix[x][y] > matrix[i][j]) {
            int len = 1 + dfs(matrix, matrixSize, matrixColSize, memo, x, y);
            if (len > maxPath) maxPath = len;
        }
    }

    memo[i][j] = maxPath;
    return maxPath;
}

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || matrixColSize[0] == 0) return 0;

    int** memo = (int**)malloc(matrixSize * sizeof(int*));
    for (int i = 0; i < matrixSize; i++) {
        memo[i] = (int*)calloc(matrixColSize[i], sizeof(int));
    }

    int result = 0;
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixColSize[i]; j++) {
            int path = dfs(matrix, matrixSize, matrixColSize, memo, i, j);
            if (path > result) result = path;
        }
    }

    for (int i = 0; i < matrixSize; i++) {
        free(memo[i]);
    }
    free(memo);

    return result;
}