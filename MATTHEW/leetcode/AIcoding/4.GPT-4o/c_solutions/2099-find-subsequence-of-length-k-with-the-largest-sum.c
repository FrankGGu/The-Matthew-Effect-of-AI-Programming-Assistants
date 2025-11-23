#include <stdlib.h>

int* maxSubsequence(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(k * sizeof(int));
    int* indices = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        indices[i] = i;
    }

    qsort(indices, numsSize, sizeof(int), (int(*)(const void*, const void*))compare);

    int count = 0;
    for (int i = numsSize - k; i < numsSize; i++) {
        result[count++] = nums[indices[i]];
    }

    qsort(result, k, sizeof(int), (int(*)(const void*, const void*))compare);

    *returnSize = k;
    free(indices);
    return result;
}

int compare(const int* a, const int* b) {
    return *a - *b;
}