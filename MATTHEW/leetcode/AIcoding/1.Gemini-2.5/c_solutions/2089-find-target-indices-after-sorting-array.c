#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* targetIndices(int* nums, int numsSize, int target, int* returnSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    if (result == NULL && count > 0) {
        *returnSize = 0;
        return NULL;
    }

    int resultIndex = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            result[resultIndex++] = i;
        }
    }

    *returnSize = count;
    return result;
}