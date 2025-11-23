int** findFarmland(int** land, int landSize, int* landColSize, int* returnSize, int** returnColumnSizes) {
    int capacity = landSize * (*landColSize) / 2;
    int** result = (int**)malloc(capacity * sizeof(int*));
    *returnColumnSizes = (int*)malloc(capacity * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < landSize; i++) {
        for (int j = 0; j < *landColSize; j++) {
            if (land[i][j] == 1) {
                int x1 = i, y1 = j;
                while (i < landSize && land[i][j] == 1) i++;
                while (j < *landColSize && land[x1][j] == 1) j++;
                result[*returnSize] = (int*)malloc(4 * sizeof(int));
                result[*returnSize][0] = x1;
                result[*returnSize][1] = y1;
                result[*returnSize][2] = i - 1;
                result[*returnSize][3] = j - 1;
                (*returnColumnSizes)[*returnSize] = 4;
                (*returnSize)++;
            }
        }
    }

    return result;
}