#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int maximumGap(int* nums, int numsSize) {
    if (numsSize < 2) return 0;

    int minVal = nums[0], maxVal = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minVal) minVal = nums[i];
        if (nums[i] > maxVal) maxVal = nums[i];
    }

    int bucketSize = (int)ceil((double)(maxVal - minVal) / (numsSize - 1));
    if (bucketSize == 0) return 0;

    int** buckets = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; i++) {
        buckets[i] = (int*)malloc(2 * sizeof(int));
        buckets[i][0] = INT_MAX;
        buckets[i][1] = INT_MIN;
    }

    for (int i = 0; i < numsSize; i++) {
        int idx = (nums[i] - minVal) / bucketSize;
        if (nums[i] < buckets[idx][0]) buckets[idx][0] = nums[i];
        if (nums[i] > buckets[idx][1]) buckets[idx][1] = nums[i];
    }

    int maxGap = 0;
    int prev = minVal;
    for (int i = 0; i < numsSize; i++) {
        if (buckets[i][0] == INT_MAX) continue;
        maxGap = fmax(maxGap, buckets[i][0] - prev);
        prev = buckets[i][1];
    }

    for (int i = 0; i < numsSize; i++) {
        free(buckets[i]);
    }
    free(buckets);

    return maxGap;
}