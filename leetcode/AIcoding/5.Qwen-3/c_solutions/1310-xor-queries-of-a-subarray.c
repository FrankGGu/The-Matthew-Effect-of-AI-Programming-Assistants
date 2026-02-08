#include <stdio.h>
#include <stdlib.h>

int* xorQueries(int* arr, int arrSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* prefix = (int*)malloc((arrSize + 1) * sizeof(int));
    prefix[0] = 0;
    for (int i = 0; i < arrSize; i++) {
        prefix[i + 1] = prefix[i] ^ arr[i];
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int l = queries[i][0];
        int r = queries[i][1];
        result[i] = prefix[r + 1] ^ prefix[l];
    }

    *returnSize = queriesSize;
    free(prefix);
    return result;
}