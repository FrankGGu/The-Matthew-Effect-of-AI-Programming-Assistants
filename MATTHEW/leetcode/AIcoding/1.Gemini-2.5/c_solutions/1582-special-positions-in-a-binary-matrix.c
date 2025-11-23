int numSpecial(int** mat, int matSize, int* matColSize) {
    int m = matSize;
    int n = matColSize[0];

    int* rowSums = (int*)calloc(m, sizeof(int));
    int* colSums = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (mat[i][j] == 1) {
                rowSums[i]++;
                colSums[j]++;
            }
        }
    }

    int specialPositions = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (mat[i][j] == 1) {
                if (rowSums[i] == 1 && colSums[j] == 1) {
                    specialPositions++;
                }
            }
        }
    }

    free(rowSums);
    free(colSums);

    return specialPositions;
}