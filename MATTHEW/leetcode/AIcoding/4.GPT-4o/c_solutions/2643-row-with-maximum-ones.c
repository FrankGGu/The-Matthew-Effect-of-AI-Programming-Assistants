int* rowAndMaximumOnes(int** mat, int matSize, int* matColSize, int* returnSize) {
    int maxCount = 0, rowIndex = -1;
    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));

    for (int i = 0; i < matSize; i++) {
        int count = 0;
        for (int j = 0; j < *matColSize; j++) {
            if (mat[i][j] == 1) {
                count++;
            }
        }
        if (count > maxCount) {
            maxCount = count;
            rowIndex = i;
        }
    }

    result[0] = rowIndex;
    result[1] = maxCount;
    return result;
}