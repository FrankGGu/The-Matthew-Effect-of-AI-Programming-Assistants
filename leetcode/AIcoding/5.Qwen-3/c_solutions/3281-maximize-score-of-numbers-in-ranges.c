#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maxScore(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    long long score = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            score += nums[i];
        } else {
            score -= nums[i];
        }
    }
    return score;
}