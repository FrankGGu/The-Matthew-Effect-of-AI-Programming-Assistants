#include <stdio.h>
#include <stdlib.h>

int countBadPairs(int* nums, int numsSize) {
    int* hash = (int*)calloc(numsSize, sizeof(int));
    int max = 0;
    for (int i = 0; i < numsSize; i++) {
        if (hash[nums[i]] > 0) {
            max = (max > hash[nums[i]] ? max : hash[nums[i]]);
        }
        hash[nums[i]]++;
    }
    return numsSize * (numsSize - 1) / 2 - max * (max - 1) / 2;
}