#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumScore(int* nums, int numsSize, int n) {
    int maxScore = 0;
    for (int i = 0; i < (1 << numsSize); i++) {
        if (__builtin_popcount(i) != n) continue;

        int currentScore = 0;
        int selectedIndex = 0;
        for (int j = 0; j < numsSize; j++) {
            if ((i >> j) & 1) {
                currentScore += nums[j];
                selectedIndex++;
            }
        }

        if (currentScore > maxScore) {
            maxScore = currentScore;
        }
    }
    return maxScore;
}