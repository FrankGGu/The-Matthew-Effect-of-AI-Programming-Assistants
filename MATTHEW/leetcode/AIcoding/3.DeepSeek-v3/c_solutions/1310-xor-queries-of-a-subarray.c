/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* xorQueries(int* arr, int arrSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* prefix = malloc((arrSize + 1) * sizeof(int));
    prefix[0] = 0;
    for (int i = 0; i < arrSize; i++) {
        prefix[i + 1] = prefix[i] ^ arr[i];
    }

    int* result = malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0];
        int right = queries[i][1];
        result[i] = prefix[right + 1] ^ prefix[left];
    }

    free(prefix);
    *returnSize = queriesSize;
    return result;
}