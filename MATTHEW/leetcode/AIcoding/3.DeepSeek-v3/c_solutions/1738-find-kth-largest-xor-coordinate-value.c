int cmp(const void *a, const void *b) {
    return *(int*)b - *(int*)a;
}

int kthLargestValue(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int m = matrixSize;
    int n = matrixColSize[0];
    int **pre = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        pre[i] = (int*)malloc(n * sizeof(int));
    }

    int *res = (int*)malloc(m * n * sizeof(int));
    int idx = 0;

    pre[0][0] = matrix[0][0];
    res[idx++] = pre[0][0];

    for (int i = 1; i < m; i++) {
        pre[i][0] = pre[i-1][0] ^ matrix[i][0];
        res[idx++] = pre[i][0];
    }

    for (int j = 1; j < n; j++) {
        pre[0][j] = pre[0][j-1] ^ matrix[0][j];
        res[idx++] = pre[0][j];
    }

    for (int i = 1; i < m; i++) {
        for (int j = 1; j < n; j++) {
            pre[i][j] = pre[i-1][j] ^ pre[i][j-1] ^ pre[i-1][j-1] ^ matrix[i][j];
            res[idx++] = pre[i][j];
        }
    }

    qsort(res, m * n, sizeof(int), cmp);

    int ans = res[k-1];

    for (int i = 0; i < m; i++) {
        free(pre[i]);
    }
    free(pre);
    free(res);

    return ans;
}