int maxEqualRowsAfterFlips(int** matrix, int matrixSize, int* matrixColSize) {
    int maxCount = 0;
    int count[1000] = {0};

    for (int i = 0; i < matrixSize; i++) {
        int key = 0;
        for (int j = 0; j < matrixColSize[i]; j++) {
            key = (key << 1) | (matrix[i][j] ^ matrix[i][0]);
        }
        count[key]++;
        if (count[key] > maxCount) {
            maxCount = count[key];
        }
    }

    return maxCount;
}