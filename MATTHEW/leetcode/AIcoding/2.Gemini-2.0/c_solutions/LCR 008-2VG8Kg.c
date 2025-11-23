#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSubArrayLen(int target, int* nums, int numsSize) {
    int left = 0;
    int sum = 0;
    int minLen = INT_MAX;

    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];

        while (sum >= target) {
            int len = right - left + 1;
            if (len < minLen) {
                minLen = len;
            }
            sum -= nums[left];
            left++;
        }
    }

    return (minLen == INT_MAX) ? 0 : minLen;
}