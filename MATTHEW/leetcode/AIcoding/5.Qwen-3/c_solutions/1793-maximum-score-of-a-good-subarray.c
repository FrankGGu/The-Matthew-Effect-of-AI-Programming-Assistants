#include <stdio.h>
#include <stdlib.h>

int maximumScore(int* nums, int numsSize, int* subarrays, int subarraysSize) {
    int maxScore = 0;
    for (int i = 0; i < subarraysSize; i += 2) {
        int left = subarrays[i];
        int right = subarrays[i + 1];
        int minVal = nums[left];
        for (int j = left; j <= right; j++) {
            if (nums[j] < minVal) {
                minVal = nums[j];
            }
        }
        int score = minVal * (right - left + 1);
        if (score > maxScore) {
            maxScore = score;
        }
    }
    return maxScore;
}