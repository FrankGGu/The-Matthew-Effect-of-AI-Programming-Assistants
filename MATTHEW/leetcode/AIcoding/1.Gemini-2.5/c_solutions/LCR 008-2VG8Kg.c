#include <limits.h>
#include <math.h>

int minSubArrayLen(int target, int* nums, int numsSize) {
    int minLen = INT_MAX;
    int currentSum = 0;
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        currentSum += nums[right];

        while (currentSum >= target) {
            minLen = fmin(minLen, right - left + 1);
            currentSum -= nums[left];
            left++;
        }
    }

    return (minLen == INT_MAX) ? 0 : minLen;
}