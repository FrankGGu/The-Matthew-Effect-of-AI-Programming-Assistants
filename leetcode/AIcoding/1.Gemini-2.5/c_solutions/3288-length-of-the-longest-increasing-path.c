#include <stdlib.h> // For malloc, calloc, free

static int dr[] = {-1, 1, 0, 0};
static int dc[] = {0, 0, -1, 1};

int dfs(int** matrix, int m, int n, int r, int c, int** dp) {
    if (dp[r][c] != 0) {
        return dp[r][c];
    }

    int max_path = 1;

    for (int k = 0; k < 4; k++) {
        int nr = r + dr[k];
        int nc = c + dc[k];

        if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
            if (matrix[nr][nc] > matrix[r][c]) {
                int path_len = 1 + dfs(matrix, m, n, nr, nc, dp);
                max_path = (max_path > path_len) ? max_path : path_len;
            }
        }
    }

    dp[r][c] = max_path;
    return max_path;
}

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || matrixColSize == NULL || matrixColSize[0] == 0) {
        return 0;
    }

    int m = matrixSize;
    int n = matrixColSize[0];

    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)calloc(n, sizeof(int));
    }

    int overall_max = 0;
    if (m > 0 && n > 0) {
        overall_max = 1;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int current_path_len = dfs(matrix, m, n, i, j, dp);
            overall_max = (overall_max > current_path_len) ? overall_max : current_path_len;
        }
    }

    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return overall_max;
}