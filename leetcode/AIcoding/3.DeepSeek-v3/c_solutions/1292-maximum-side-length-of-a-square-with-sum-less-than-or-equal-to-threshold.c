int maxSideLength(int** mat, int matSize, int* matColSize, int threshold) {
    int m = matSize, n = matColSize[0];
    int** prefix = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        prefix[i] = (int*)calloc(n + 1, sizeof(int));
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            prefix[i][j] = mat[i-1][j-1] + prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1];
        }
    }

    int maxLen = 0;
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            for (int k = maxLen + 1; k <= m && k <= n; k++) {
                if (i + k - 1 > m || j + k - 1 > n) break;
                int sum = prefix[i+k-1][j+k-1] - prefix[i-1][j+k-1] - prefix[i+k-1][j-1] + prefix[i-1][j-1];
                if (sum <= threshold) {
                    maxLen = k;
                } else {
                    break;
                }
            }
        }
    }

    for (int i = 0; i <= m; i++) {
        free(prefix[i]);
    }
    free(prefix);

    return maxLen;
}