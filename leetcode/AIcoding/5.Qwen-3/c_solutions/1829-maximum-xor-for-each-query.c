#include <stdio.h>
#include <stdlib.h>

int* maximizeXor(int* nums, int numsSize, int* queries, int queriesSize, int** returnColumnSizes, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;
    *returnColumnSizes = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        (*returnColumnSizes)[i] = 1;
    }

    for (int i = 0; i < queriesSize; i++) {
        int x = queries[i];
        int max_xor = 0;
        for (int j = 0; j < numsSize; j++) {
            max_xor = (max_xor > (nums[j] ^ x)) ? max_xor : (nums[j] ^ x);
        }
        result[i] = max_xor;
    }

    return result;
}