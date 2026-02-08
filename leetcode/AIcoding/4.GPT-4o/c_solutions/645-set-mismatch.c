#include <stdlib.h>

int* findErrorNums(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    int* count = (int*)calloc(numsSize + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    for (int i = 1; i <= numsSize; i++) {
        if (count[i] == 2) {
            result[0] = i;
        } else if (count[i] == 0) {
            result[1] = i;
        }
    }

    *returnSize = 2;
    free(count);
    return result;
}