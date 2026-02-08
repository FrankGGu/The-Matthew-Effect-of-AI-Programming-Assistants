/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int** firstThreeRows(int** data, int dataSize, int* dataColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = dataSize < 3 ? dataSize : 3;
    *returnColumnSizes = (int*)malloc(*returnSize * sizeof(int));
    int** result = (int**)malloc(*returnSize * sizeof(int*));

    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = dataColSize[i];
        result[i] = (int*)malloc(dataColSize[i] * sizeof(int));
        for (int j = 0; j < dataColSize[i]; j++) {
            result[i][j] = data[i][j];
        }
    }

    return result;
}