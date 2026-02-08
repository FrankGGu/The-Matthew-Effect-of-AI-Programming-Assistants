int maximumRows(int** matrix, int matrixSize, int* matrixColSize, int numSelect) {
    int m = matrixSize;
    int n = matrixColSize[0];

    if (numSelect == n) return m;

    int* rowMasks = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        rowMasks[i] = 0;
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == 1) {
                rowMasks[i] |= (1 << j);
            }
        }
    }

    int maxRows = 0;
    int limit = (1 << n);

    for (int mask = 0; mask < limit; mask++) {
        if (__builtin_popcount(mask) != numSelect) continue;

        int count = 0;
        for (int i = 0; i < m; i++) {
            if ((rowMasks[i] & mask) == rowMasks[i]) {
                count++;
            }
        }

        if (count > maxRows) {
            maxRows = count;
        }
    }

    free(rowMasks);
    return maxRows;
}