int** createMatrix(int rows, int cols) {
    int** mat = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        mat[i] = (int*)calloc(cols, sizeof(int));
    }
    return mat;
}

void freeMatrix(int** mat, int rows) {
    for (int i = 0; i < rows; i++) {
        free(mat[i]);
    }
    free(mat);
}

bool possibleToStamp(int** grid, int gridSize, int* gridColSize, int stampHeight, int stampWidth) {
    int m = gridSize;
    int n = gridColSize[0];

    int** sum = createMatrix(m + 1, n + 1);
    int** diff = createMatrix(m + 2, n + 2);

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            sum[i][j] = grid[i-1][j-1] + sum[i-1][j] + sum[i][j-1] - sum[i-1][j-1];
        }
    }

    for (int i = 1; i + stampHeight - 1 <= m; i++) {
        for (int j = 1; j + stampWidth - 1 <= n; j++) {
            int x = i + stampHeight - 1;
            int y = j + stampWidth - 1;
            if (sum[x][y] - sum[i-1][y] - sum[x][j-1] + sum[i-1][j-1] == 0) {
                diff[i][j]++;
                diff[i][y+1]--;
                diff[x+1][j]--;
                diff[x+1][y+1]++;
            }
        }
    }

    int** grid2 = createMatrix(m + 2, n + 2);
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            grid2[i][j] = grid2[i-1][j] + grid2[i][j-1] - grid2[i-1][j-1] + diff[i][j];
            if (grid[i-1][j-1] == 0 && grid2[i][j] == 0) {
                freeMatrix(sum, m + 1);
                freeMatrix(diff, m + 2);
                freeMatrix(grid2, m + 2);
                return false;
            }
        }
    }

    freeMatrix(sum, m + 1);
    freeMatrix(diff, m + 2);
    freeMatrix(grid2, m + 2);
    return true;
}