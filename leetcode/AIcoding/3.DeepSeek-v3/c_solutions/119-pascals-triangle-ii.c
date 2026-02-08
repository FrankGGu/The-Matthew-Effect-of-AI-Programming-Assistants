int* getRow(int rowIndex, int* returnSize) {
    *returnSize = rowIndex + 1;
    int* row = (int*)malloc((rowIndex + 1) * sizeof(int));
    row[0] = 1;

    for (int i = 1; i <= rowIndex; i++) {
        row[i] = 1;
        for (int j = i - 1; j > 0; j--) {
            row[j] = row[j] + row[j - 1];
        }
    }

    return row;
}