int* pondSizes(int** land, int landSize, int* landColSize, int* returnSize) {
    int m = landSize, n = landColSize[0];
    int* res = (int*)malloc(m * n * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (land[i][j] == 0) {
                int size = dfs(land, i, j, m, n);
                res[(*returnSize)++] = size;
            }
        }
    }

    for (int i = 0; i < *returnSize - 1; i++) {
        for (int j = 0; j < *returnSize - i - 1; j++) {
            if (res[j] > res[j + 1]) {
                int temp = res[j];
                res[j] = res[j + 1];
                res[j + 1] = temp;
            }
        }
    }

    return res;
}

int dfs(int** land, int i, int j, int m, int n) {
    if (i < 0 || i >= m || j < 0 || j >= n || land[i][j] != 0) {
        return 0;
    }
    land[i][j] = -1;
    int size = 1;
    for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
            if (dx == 0 && dy == 0) continue;
            size += dfs(land, i + dx, j + dy, m, n);
        }
    }
    return size;
}