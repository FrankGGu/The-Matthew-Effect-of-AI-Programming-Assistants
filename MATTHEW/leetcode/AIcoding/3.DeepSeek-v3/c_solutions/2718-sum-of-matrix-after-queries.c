long long matrixSumQueries(int n, int** queries, int queriesSize, int* queriesColSize) {
    int* row = (int*)calloc(n, sizeof(int));
    int* col = (int*)calloc(n, sizeof(int));
    int row_count = 0, col_count = 0;
    long long sum = 0;

    for (int i = queriesSize - 1; i >= 0; i--) {
        int type = queries[i][0];
        int index = queries[i][1];
        int val = queries[i][2];

        if (type == 0) {
            if (row[index]) continue;
            row[index] = 1;
            row_count++;
            sum += (long long)val * (n - col_count);
        } else {
            if (col[index]) continue;
            col[index] = 1;
            col_count++;
            sum += (long long)val * (n - row_count);
        }
    }

    free(row);
    free(col);
    return sum;
}