int* matrixSumQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    long long totalSum = 0;
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* rowCount = (int*)calloc(n, sizeof(int));
    int* colCount = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < queriesSize; i++) {
        int r = queries[i][0], c = queries[i][1], v = queries[i][2];
        if (rowCount[r] == 0) totalSum += (long long)v * n - (long long)colCount[r] * v;
        if (colCount[c] == 0) totalSum += (long long)v * n - (long long)rowCount[c] * v;
        rowCount[r]++;
        colCount[c]++;
        result[i] = totalSum;
    }

    *returnSize = queriesSize;
    free(rowCount);
    free(colCount);
    return result;
}