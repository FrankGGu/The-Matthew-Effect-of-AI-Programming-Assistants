#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumScore(int* nums, int numsSize, int k){
    int left = k, right = k;
    int minVal = nums[k];
    int maxScore = minVal;

    while (left > 0 || right < numsSize - 1) {
        if (left == 0) {
            right++;
        } else if (right == numsSize - 1) {
            left--;
        } else if (nums[left - 1] < nums[right + 1]) {
            right++;
        } else {
            left--;
        }

        minVal = nums[left];
        for (int i = left; i <= right; i++) {
            if (nums[i] < minVal) {
                minVal = nums[i];
            }
        }

        int currentScore = minVal * (right - left + 1);
        if (currentScore > maxScore) {
            maxScore = currentScore;
        }
    }

    return maxScore;
}