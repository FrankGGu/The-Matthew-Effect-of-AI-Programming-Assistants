#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumGap(int* nums, int numsSize) {
    if (numsSize < 2) return 0;

    int minVal = nums[0];
    int maxVal = nums[0];
    for (int i = 1; i < numsSize; i++) {
        minVal = (nums[i] < minVal) ? nums[i] : minVal;
        maxVal = (nums[i] > maxVal) ? nums[i] : maxVal;
    }

    if (maxVal == minVal) return 0;

    int bucketSize = (maxVal - minVal) / (numsSize - 1);
    if (bucketSize == 0) bucketSize = 1;

    int bucketCount = (maxVal - minVal) / bucketSize + 1;
    int* minBucket = (int*)malloc(bucketCount * sizeof(int));
    int* maxBucket = (int*)malloc(bucketCount * sizeof(int));
    for (int i = 0; i < bucketCount; i++) {
        minBucket[i] = INT_MAX;
        maxBucket[i] = INT_MIN;
    }

    for (int i = 0; i < numsSize; i++) {
        int bucketIndex = (nums[i] - minVal) / bucketSize;
        minBucket[bucketIndex] = (nums[i] < minBucket[bucketIndex]) ? nums[i] : minBucket[bucketIndex];
        maxBucket[bucketIndex] = (nums[i] > maxBucket[bucketIndex]) ? nums[i] : maxBucket[bucketIndex];
    }

    int maxGap = 0;
    int prevMax = maxBucket[0];
    for (int i = 1; i < bucketCount; i++) {
        if (minBucket[i] == INT_MAX) continue;
        int gap = minBucket[i] - prevMax;
        maxGap = (gap > maxGap) ? gap : maxGap;
        prevMax = maxBucket[i];
    }

    free(minBucket);
    free(maxBucket);

    return maxGap;
}