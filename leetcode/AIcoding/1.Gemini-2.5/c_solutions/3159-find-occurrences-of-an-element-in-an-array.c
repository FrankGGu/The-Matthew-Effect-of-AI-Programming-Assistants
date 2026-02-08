#include <stdlib.h>

int* occurrencesOfElement(int* nums, int numsSize, int* queries, int queriesSize, int target, int* returnSize) {
    int* target_indices = (int*)malloc(numsSize * sizeof(int));
    int target_count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            target_indices[target_count++] = i;
        }
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int query_k = queries[i];
        if (query_k < target_count) {
            result[i] = target_indices[query_k];
        } else {
            result[i] = -1;
        }
    }

    free(target_indices);

    return result;
}