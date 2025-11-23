int maxIncreasingCells(int** mat, int matSize, int* matColSize) {
    int n = matSize, m = *matColSize;
    int dp[n][m], maxCells = 0;
    int sorted[n * m][3], index = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            sorted[index][0] = mat[i][j];
            sorted[index][1] = i;
            sorted[index][2] = j;
            index++;
        }
    }

    qsort(sorted, n * m, sizeof(sorted[0]), [](const void* a, const void* b) {
        return (*(int(*)[3])a)[0] - (*(int(*)[3])b)[0];
    });

    int rowMax[n], colMax[m];
    memset(rowMax, 0, sizeof(rowMax));
    memset(colMax, 0, sizeof(colMax));

    for (int k = 0; k < n * m; k++) {
        int value = sorted[k][0];
        int r = sorted[k][1];
        int c = sorted[k][2];
        int rowCount = rowMax[r] + 1;
        int colCount = colMax[c] + 1;
        dp[r][c] = rowCount > colCount ? rowCount : colCount;
        rowMax[r] = dp[r][c];
        colMax[c] = dp[r][c];
        maxCells = maxCells > dp[r][c] ? maxCells : dp[r][c];
    }

    return maxCells;
}