#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumScore(int* nums, int numsSize) {
    if (numsSize <= 3) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int score1 = nums[numsSize - 3] - nums[0];
    int score2 = nums[numsSize - 1] - nums[2];
    int score3 = nums[numsSize - 2] - nums[1];

    int minScore = score1;
    if (score2 < minScore) {
        minScore = score2;
    }
    if (score3 < minScore) {
        minScore = score3;
    }

    return minScore;
}