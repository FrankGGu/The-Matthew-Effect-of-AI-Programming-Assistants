int minSwapsCouples(int* row, int rowSize) {
    int n = rowSize;
    int *pos = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        pos[row[i]] = i;
    }

    int swaps = 0;
    for (int i = 0; i < n; i += 2) {
        int x = row[i];
        int y = x ^ 1;
        if (row[i + 1] != y) {
            int j = pos[y];
            row[j] = row[i + 1];
            pos[row[i + 1]] = j;
            row[i + 1] = y;
            pos[y] = i + 1;
            swaps++;
        }
    }
    free(pos);
    return swaps;
}