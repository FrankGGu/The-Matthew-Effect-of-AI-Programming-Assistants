#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* numberGame(int* nums, int numsSize, int* returnSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int* arr = (int*)malloc(numsSize * sizeof(int));
    if (arr == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < numsSize; i += 2) {
        arr[i] = nums[i+1];
        arr[i+1] = nums[i];
    }

    *returnSize = numsSize;
    return arr;
}