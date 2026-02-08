#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findLonely(int* nums, int numsSize, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int* hash = (int*)malloc(200002 * sizeof(int));
    for (int i = 0; i < 200002; i++) {
        hash[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        hash[nums[i] + 100000]++;
    }

    int* result = (int*)malloc(numsSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (hash[nums[i] + 100000] == 1 &&
            (nums[i] + 100000 - 1 < 0 || hash[nums[i] + 100000 - 1] == 0) &&
            (nums[i] + 100000 + 1 >= 200002 || hash[nums[i] + 100000 + 1] == 0)) {
            result[count++] = nums[i];
        }
    }

    *returnSize = count;
    return result;
}