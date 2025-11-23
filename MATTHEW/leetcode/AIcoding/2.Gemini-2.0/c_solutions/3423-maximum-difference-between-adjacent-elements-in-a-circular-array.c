#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDiff(int* nums, int numsSize) {
    if (numsSize < 2) {
        return 0;
    }
    int max_diff = INT_MIN;
    for (int i = 0; i < numsSize; i++) {
        int diff = abs(nums[i] - nums[(i + 1) % numsSize]);
        if (diff > max_diff) {
            max_diff = diff;
        }
    }
    return max_diff;
}