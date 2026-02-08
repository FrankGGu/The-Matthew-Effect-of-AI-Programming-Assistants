int** rangeAddQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize, int** returnColumnSizes) {
    int** mat = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        mat[i] = (int*)calloc(n, sizeof(int));
    }

    for (int q = 0; q < queriesSize; q++) {
        int r1 = queries[q][0];
        int c1 = queries[q][1];
        int r2 = queries[q][2];
        int c2 = queries[q][3];

        for (int i = r1; i <= r2; i++) {
            mat[i][c1]++;
            if (c2 + 1 < n) {
                mat[i][c2 + 1]--;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 1; j < n; j++) {
            mat[i][j] += mat[i][j - 1];
        }
    }

    *returnSize = n;
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        (*returnColumnSizes)[i] = n;
    }

    return mat;
}