#include <stdlib.h>

int* findLonely(int* nums, int numsSize, int* returnSize) {
    int* count = (int*)calloc(1001, sizeof(int));
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        count[nums[i] + 500]++;  // Offset to handle negative indices
    }

    for (int i = 0; i < numsSize; i++) {
        if (count[nums[i] + 500] == 1 &&
            count[nums[i] + 499] == 0 &&
            count[nums[i] + 501] == 0) {
            result[(*returnSize)++] = nums[i];
        }
    }

    free(count);
    return result;
}