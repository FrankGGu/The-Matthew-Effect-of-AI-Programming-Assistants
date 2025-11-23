#include <stdio.h>
#include <stdlib.h>

int maximumDivisibilityScore(int* nums, int numsSize) {
    int maxScore = -1;
    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        int score = 0;
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] % nums[i] == 0) {
                score++;
            }
        }
        if (score > maxScore || (score == maxScore && nums[i] < result)) {
            maxScore = score;
            result = nums[i];
        }
    }
    return result;
}