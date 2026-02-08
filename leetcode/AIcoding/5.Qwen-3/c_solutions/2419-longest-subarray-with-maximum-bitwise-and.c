#include <stdio.h>
#include <stdlib.h>

int longestSubarray(int* nums, int numsSize) {
    int maxAnd = 0;
    int currentAnd = 0;
    int maxLength = 0;
    int currentLength = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i == 0 || (nums[i] & nums[i - 1]) == nums[i]) {
            currentAnd = nums[i];
            currentLength = 1;
        } else {
            currentAnd = nums[i];
            currentLength = 1;
        }

        for (int j = i + 1; j < numsSize; j++) {
            currentAnd &= nums[j];
            currentLength++;
            if (currentAnd > maxAnd) {
                maxAnd = currentAnd;
                maxLength = currentLength;
            } else if (currentAnd == maxAnd) {
                maxLength = (currentLength > maxLength) ? currentLength : maxLength;
            }
        }
    }

    return maxLength;
}