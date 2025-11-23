#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDivScore(int* nums, int numsSize, int* divisors, int divisorsSize) {
    int maxScore = -1;
    int result = -1;

    for (int i = 0; i < divisorsSize; i++) {
        int score = 0;
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] % divisors[i] == 0) {
                score++;
            }
        }

        if (score > maxScore) {
            maxScore = score;
            result = divisors[i];
        } else if (score == maxScore) {
            if (divisors[i] < result) {
                result = divisors[i];
            }
        }
    }

    return result;
}