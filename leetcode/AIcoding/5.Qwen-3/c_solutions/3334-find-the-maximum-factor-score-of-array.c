#include <stdio.h>
#include <stdlib.h>

long long maxFactorScore(int* nums, int numsSize) {
    long long maxScore = 0;
    for (int i = 0; i < numsSize; i++) {
        long long score = 1;
        for (int j = 1; j <= nums[i]; j++) {
            if (nums[i] % j == 0) {
                score *= j;
            }
        }
        if (score > maxScore) {
            maxScore = score;
        }
    }
    return maxScore;
}