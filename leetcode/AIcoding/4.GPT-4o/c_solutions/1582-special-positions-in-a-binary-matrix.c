int numSpecial(int** mat, int matSize, int* matColSize) {
    int rows[matSize], cols[*matColSize];
    memset(rows, 0, sizeof(rows));
    memset(cols, 0, sizeof(cols));

    for (int i = 0; i < matSize; i++) {
        for (int j = 0; j < *matColSize; j++) {
            if (mat[i][j] == 1) {
                rows[i]++;
                cols[j]++;
            }
        }
    }

    int specialCount = 0;
    for (int i = 0; i < matSize; i++) {
        for (int j = 0; j < *matColSize; j++) {
            if (mat[i][j] == 1 && rows[i] == 1 && cols[j] == 1) {
                specialCount++;
            }
        }
    }

    return specialCount;
}