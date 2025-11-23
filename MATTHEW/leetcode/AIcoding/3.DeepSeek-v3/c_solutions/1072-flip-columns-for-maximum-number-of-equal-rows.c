int maxEqualRowsAfterFlips(int** matrix, int matrixSize, int* matrixColSize) {
    int m = matrixSize;
    int n = matrixColSize[0];

    int max = 0;

    for (int i = 0; i < m; i++) {
        int count = 0;
        int* flip = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            flip[j] = matrix[i][j] ^ matrix[i][0];
        }

        for (int k = i; k < m; k++) {
            int match = 1;
            for (int j = 0; j < n; j++) {
                if (flip[j] != (matrix[k][j] ^ matrix[k][0])) {
                    match = 0;
                    break;
                }
            }
            if (match) count++;
        }

        if (count > max) max = count;
        free(flip);
    }

    return max;
}