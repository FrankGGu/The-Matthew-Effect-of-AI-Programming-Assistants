int maximumGap(int* nums, int numsSize) {
    if (numsSize < 2) return 0;

    int minVal = INT_MAX, maxVal = INT_MIN;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < minVal) minVal = nums[i];
        if (nums[i] > maxVal) maxVal = nums[i];
    }

    if (minVal == maxVal) return 0;

    int bucketSize = (maxVal - minVal) / numsSize + 1;
    int bucketCount = (maxVal - minVal) / bucketSize + 1;

    int* minBucket = (int*)malloc(bucketCount * sizeof(int));
    int* maxBucket = (int*)malloc(bucketCount * sizeof(int));

    for (int i = 0; i < bucketCount; i++) {
        minBucket[i] = INT_MAX;
        maxBucket[i] = INT_MIN;
    }

    for (int i = 0; i < numsSize; i++) {
        int idx = (nums[i] - minVal) / bucketSize;
        if (nums[i] < minBucket[idx]) minBucket[idx] = nums[i];
        if (nums[i] > maxBucket[idx]) maxBucket[idx] = nums[i];
    }

    int maxGap = 0;
    int prevMax = minVal;

    for (int i = 0; i < bucketCount; i++) {
        if (minBucket[i] == INT_MAX) continue;
        if (minBucket[i] - prevMax > maxGap) {
            maxGap = minBucket[i] - prevMax;
        }
        prevMax = maxBucket[i];
    }

    free(minBucket);
    free(maxBucket);

    return maxGap;
}