#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countAlmostEqualPairs(int* nums, int numsSize, int diff) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (abs(nums[i] - nums[j]) <= diff) {
                count++;
            }
        }
    }
    return count;
}