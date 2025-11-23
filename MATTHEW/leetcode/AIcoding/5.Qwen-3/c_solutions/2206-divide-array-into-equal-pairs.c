#include <stdio.h>
#include <stdlib.h>

bool canBeDividedIntoEqualPairs(int* nums, int numsSize) {
    int* count = (int*)calloc(101, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }
    for (int i = 0; i <= 100; i++) {
        if (count[i] % 2 != 0) {
            free(count);
            return false;
        }
    }
    free(count);
    return true;
}