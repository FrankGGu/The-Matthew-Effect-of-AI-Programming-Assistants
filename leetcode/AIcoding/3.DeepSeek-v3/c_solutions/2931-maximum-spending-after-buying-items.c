int maxSpending(int** values, int valuesSize, int* valuesColSize) {
    int m = valuesSize;
    int n = valuesColSize[0];
    int total = m * n;
    int* all = (int*)malloc(total * sizeof(int));
    int idx = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            all[idx++] = values[i][j];
        }
    }
    for (int i = 0; i < total - 1; i++) {
        for (int j = 0; j < total - i - 1; j++) {
            if (all[j] > all[j + 1]) {
                int temp = all[j];
                all[j] = all[j + 1];
                all[j + 1] = temp;
            }
        }
    }
    long long result = 0;
    for (int day = 1; day <= total; day++) {
        result += (long long)all[day - 1] * day;
    }
    free(all);
    return result;
}