int oddCells(int m, int n, int** indices, int indicesSize, int* indicesColSize) {
    int* rows = (int*)calloc(m, sizeof(int));
    int* cols = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < indicesSize; i++) {
        rows[indices[i][0]]++;
        cols[indices[i][1]]++;
    }

    int oddCount = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if ((rows[i] + cols[j]) % 2 == 1) {
                oddCount++;
            }
        }
    }

    free(rows);
    free(cols);
    return oddCount;
}