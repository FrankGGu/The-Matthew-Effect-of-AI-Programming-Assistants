#include <stdio.h>
#include <stdlib.h>

bool containsDuplicate(int* nums, int numsSize) {
    if (nums == NULL || numsSize <= 0) {
        return false;
    }

    int* hash = (int*)malloc(sizeof(int) * numsSize);
    if (hash == NULL) {
        return false;
    }

    for (int i = 0; i < numsSize; i++) {
        int index = abs(nums[i]) % numsSize;
        while (hash[index] != 0) {
            if (hash[index] == nums[i]) {
                free(hash);
                return true;
            }
            index = (index + 1) % numsSize;
        }
        hash[index] = nums[i];
    }

    free(hash);
    return false;
}