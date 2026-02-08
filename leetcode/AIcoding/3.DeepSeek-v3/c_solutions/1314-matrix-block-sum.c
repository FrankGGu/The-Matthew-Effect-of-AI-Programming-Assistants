int** matrixBlockSum(int** mat, int matSize, int* matColSize, int k, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = matColSize[0];

    int** prefix = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        prefix[i] = (int*)calloc(n + 1, sizeof(int));
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            prefix[i][j] = mat[i-1][j-1] + prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1];
        }
    }

    int** ans = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    *returnSize = m;

    for (int i = 0; i < m; i++) {
        ans[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
        for (int j = 0; j < n; j++) {
            int r1 = fmax(0, i - k);
            int c1 = fmax(0, j - k);
            int r2 = fmin(m - 1, i + k);
            int c2 = fmin(n - 1, j + k);

            ans[i][j] = prefix[r2+1][c2+1] - prefix[r1][c2+1] - prefix[r2+1][c1] + prefix[r1][c1];
        }
    }

    for (int i = 0; i <= m; i++) {
        free(prefix[i]);
    }
    free(prefix);

    return ans;
}