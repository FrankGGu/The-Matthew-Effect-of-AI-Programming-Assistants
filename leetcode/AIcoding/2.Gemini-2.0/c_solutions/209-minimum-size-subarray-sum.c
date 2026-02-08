#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSubArrayLen(int target, int* nums, int numsSize) {
    int minLen = INT_MAX;
    int windowStart = 0;
    int windowSum = 0;

    for (int windowEnd = 0; windowEnd < numsSize; windowEnd++) {
        windowSum += nums[windowEnd];

        while (windowSum >= target) {
            int currentLen = windowEnd - windowStart + 1;
            if (currentLen < minLen) {
                minLen = currentLen;
            }
            windowSum -= nums[windowStart];
            windowStart++;
        }
    }

    if (minLen == INT_MAX) {
        return 0;
    } else {
        return minLen;
    }
}