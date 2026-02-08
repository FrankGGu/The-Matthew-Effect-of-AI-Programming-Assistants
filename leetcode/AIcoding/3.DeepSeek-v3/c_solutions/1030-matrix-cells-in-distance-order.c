/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** allCellsDistOrder(int rows, int cols, int rCenter, int cCenter, int* returnSize, int** returnColumnSizes) {
    int maxDist = fmax(rCenter, rows - 1 - rCenter) + fmax(cCenter, cols - 1 - cCenter);
    int** buckets = (int**)malloc((maxDist + 1) * sizeof(int*));
    int* bucketSizes = (int*)calloc((maxDist + 1), sizeof(int));

    for (int i = 0; i <= maxDist; i++) {
        buckets[i] = (int*)malloc(rows * cols * 2 * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int dist = abs(i - rCenter) + abs(j - cCenter);
            int idx = bucketSizes[dist] * 2;
            buckets[dist][idx] = i;
            buckets[dist][idx + 1] = j;
            bucketSizes[dist]++;
        }
    }

    *returnSize = rows * cols;
    int** result = (int**)malloc((*returnSize) * sizeof(int*));
    *returnColumnSizes = (int*)malloc((*returnSize) * sizeof(int));

    int index = 0;
    for (int d = 0; d <= maxDist; d++) {
        for (int i = 0; i < bucketSizes[d]; i++) {
            result[index] = (int*)malloc(2 * sizeof(int));
            result[index][0] = buckets[d][i * 2];
            result[index][1] = buckets[d][i * 2 + 1];
            (*returnColumnSizes)[index] = 2;
            index++;
        }
        free(buckets[d]);
    }

    free(buckets);
    free(bucketSizes);

    return result;
}