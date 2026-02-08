#include <stdio.h>
#include <stdlib.h>

int* findIndices(int* nums, int numsSize, int indexDifference, int valueDifference, int* returnSize) {
    *returnSize = 0;
    int* result = (int*)malloc(2 * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + indexDifference; j < numsSize; j++) {
            if (abs(nums[i] - nums[j]) >= valueDifference) {
                result[0] = i;
                result[1] = j;
                *returnSize = 2;
                return result;
            }
        }
    }
    free(result);
    *returnSize = 0;
    return NULL;
}