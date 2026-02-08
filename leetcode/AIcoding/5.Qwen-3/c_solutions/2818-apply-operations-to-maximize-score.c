#include <stdio.h>
#include <stdlib.h>

long long maximumScore(long long* nums, int numsSize, int k) {
    long long maxScore = 0;
    long long minVal = nums[k];
    long long left = k;
    long long right = k;

    while (left >= 0 && right < numsSize) {
        minVal = fmin(nums[left], nums[right]);
        maxScore = fmax(maxScore, minVal * (right - left + 1));

        if (left > 0 && nums[left - 1] > nums[right]) {
            left--;
        } else if (right < numsSize - 1 && nums[right + 1] > nums[left]) {
            right++;
        } else {
            if (left > 0) {
                left--;
            } else {
                right++;
            }
        }
    }

    return maxScore;
}