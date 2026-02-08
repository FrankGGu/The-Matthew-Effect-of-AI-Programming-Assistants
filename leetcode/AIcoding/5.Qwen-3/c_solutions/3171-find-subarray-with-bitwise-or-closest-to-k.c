#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int closestToK(int* nums, int numsSize, int k) {
    int minDiff = INT_MAX;
    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        int currentOr = 0;
        for (int j = i; j < numsSize; j++) {
            currentOr |= nums[j];
            int diff = abs(currentOr - k);
            if (diff < minDiff || (diff == minDiff && currentOr < result)) {
                minDiff = diff;
                result = currentOr;
            }
        }
    }
    return result;
}