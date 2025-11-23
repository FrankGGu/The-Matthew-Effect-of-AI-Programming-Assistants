#include <stdio.h>
#include <stdlib.h>

int* subarrayXor(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* prefixXor = (int*)malloc((numsSize + 1) * sizeof(int));

    prefixXor[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixXor[i + 1] = prefixXor[i] ^ nums[i];
    }

    for (int i = 0; i < queriesSize; i++) {
        int l = queries[i][0];
        int r = queries[i][1];
        result[i] = prefixXor[r + 1] ^ prefixXor[l];
    }

    *returnSize = queriesSize;
    free(prefixXor);
    return result;
}