int firstCompleteIndex(int** mat, int matSize, int* matColSize, int* row, int* col) {
    int n = matSize, m = *matColSize;
    int rowCount[n], colCount[m];
    memset(rowCount, 0, sizeof(rowCount));
    memset(colCount, 0, sizeof(colCount));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (rowCount[i] < 0) continue;
            rowCount[i]++;
            if (rowCount[i] == m) return i;
        }
    }

    for (int j = 0; j < m; j++) {
        for (int i = 0; i < n; i++) {
            if (colCount[j] < 0) continue;
            colCount[j]++;
            if (colCount[j] == n) return j;
        }
    }

    return -1;
}