int countSubmatrices(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int** prefixX = (int**)malloc((m + 1) * sizeof(int*));
    int** prefixY = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        prefixX[i] = (int*)calloc(n + 1, sizeof(int));
        prefixY[i] = (int*)calloc(n + 1, sizeof(int));
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            prefixX[i][j] = prefixX[i-1][j] + prefixX[i][j-1] - prefixX[i-1][j-1];
            prefixY[i][j] = prefixY[i-1][j] + prefixY[i][j-1] - prefixY[i-1][j-1];

            if (grid[i-1][j-1] == 'X') {
                prefixX[i][j]++;
            } else if (grid[i-1][j-1] == 'Y') {
                prefixY[i][j]++;
            }
        }
    }

    int count = 0;
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            int xCount = prefixX[i][j];
            int yCount = prefixY[i][j];
            if (xCount == yCount && xCount > 0) {
                count++;
            }
        }
    }

    for (int i = 0; i <= m; i++) {
        free(prefixX[i]);
        free(prefixY[i]);
    }
    free(prefixX);
    free(prefixY);

    return count;
}