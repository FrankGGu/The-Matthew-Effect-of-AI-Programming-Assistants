#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minScore(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    int minScore = INT_MAX;
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i + 1] - nums[i] < minScore) {
            minScore = nums[i + 1] - nums[i];
        }
    }
    return minScore;
}