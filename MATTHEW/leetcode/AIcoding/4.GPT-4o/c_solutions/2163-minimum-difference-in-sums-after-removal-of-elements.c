#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minimumDifference(int* nums, int numsSize) {
    int half = numsSize / 2;
    int total = 0, sum1, sum2;
    int* leftSums = (int*)malloc((1 << half) * sizeof(int));
    int* rightSums = (int*)malloc((1 << half) * sizeof(int));

    for (int i = 0; i < half; i++) {
        total += nums[i];
    }

    int leftCount = 1 << half;
    for (int i = 0; i < leftCount; i++) {
        sum1 = 0;
        for (int j = 0; j < half; j++) {
            if (i & (1 << j)) {
                sum1 += nums[j];
            }
        }
        leftSums[i] = sum1;
    }

    total = 0;
    for (int i = half; i < numsSize; i++) {
        total += nums[i];
    }

    int rightCount = 1 << (numsSize - half);
    for (int i = 0; i < rightCount; i++) {
        sum2 = 0;
        for (int j = 0; j < (numsSize - half); j++) {
            if (i & (1 << j)) {
                sum2 += nums[half + j];
            }
        }
        rightSums[i] = sum2;
    }

    qsort(leftSums, leftCount, sizeof(int), cmp);
    qsort(rightSums, rightCount, sizeof(int), cmp);

    int minDiff = INT_MAX;
    for (int i = 0; i < leftCount; i++) {
        int target = total - leftSums[i];
        int* pos = bsearch(&target, rightSums, rightCount, sizeof(int), cmp);
        if (pos) {
            minDiff = fmin(minDiff, abs(target - *pos));
        } else {
            int idx = -(pos + 1 - rightSums);
            if (idx > 0) {
                minDiff = fmin(minDiff, abs(target - rightSums[idx - 1]));
            }
            if (idx < rightCount) {
                minDiff = fmin(minDiff, abs(target - rightSums[idx]));
            }
        }
    }

    free(leftSums);
    free(rightSums);

    return minDiff;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}