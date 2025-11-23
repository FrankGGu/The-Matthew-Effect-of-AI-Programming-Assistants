#include <stdlib.h>

int* xorQueries(int* arr, int arrSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* prefixXOR = (int*)malloc((arrSize + 1) * sizeof(int));
    prefixXOR[0] = 0;
    for (int i = 0; i < arrSize; i++) {
        prefixXOR[i+1] = prefixXOR[i] ^ arr[i];
    }

    int* results = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0];
        int right = queries[i][1];
        results[i] = prefixXOR[right + 1] ^ prefixXOR[left];
    }

    free(prefixXOR);
    return results;
}