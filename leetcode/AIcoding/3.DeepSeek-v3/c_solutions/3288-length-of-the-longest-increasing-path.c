int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

int dfs(int** matrix, int matrixSize, int* matrixColSize, int i, int j, int** memo) {
    if (memo[i][j] != 0) return memo[i][j];

    int maxPath = 1;
    for (int k = 0; k < 4; k++) {
        int x = i + directions[k][0];
        int y = j + directions[k][1];

        if (x >= 0 && x < matrixSize && y >= 0 && y < *matrixColSize && matrix[x][y] > matrix[i][j]) {
            int len = 1 + dfs(matrix, matrixSize, matrixColSize, x, y, memo);
            if (len > maxPath) maxPath = len;
        }
    }

    memo[i][j] = maxPath;
    return maxPath;
}

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) return 0;

    int** memo = (int**)malloc(matrixSize * sizeof(int*));
    for (int i = 0; i < matrixSize; i++) {
        memo[i] = (int*)calloc(*matrixColSize, sizeof(int));
    }

    int longest = 0;
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < *matrixColSize; j++) {
            int path = dfs(matrix, matrixSize, matrixColSize, i, j, memo);
            if (path > longest) longest = path;
        }
    }

    for (int i = 0; i < matrixSize; i++) {
        free(memo[i]);
    }
    free(memo);

    return longest;
}