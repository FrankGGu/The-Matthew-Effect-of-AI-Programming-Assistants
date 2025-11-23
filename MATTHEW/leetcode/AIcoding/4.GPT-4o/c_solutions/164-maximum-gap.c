int maximumGap(int* nums, int numsSize) {
    if (numsSize < 2) return 0;

    int minVal = nums[0], maxVal = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minVal) minVal = nums[i];
        if (nums[i] > maxVal) maxVal = nums[i];
    }

    if (maxVal == minVal) return 0;

    int bucketSize = (maxVal - minVal) / (numsSize - 1) + 1;
    int bucketCount = (maxVal - minVal) / bucketSize + 1;
    int* bucketMin = (int*)malloc(bucketCount * sizeof(int));
    int* bucketMax = (int*)malloc(bucketCount * sizeof(int));
    for (int i = 0; i < bucketCount; i++) {
        bucketMin[i] = INT_MAX;
        bucketMax[i] = INT_MIN;
    }

    for (int i = 0; i < numsSize; i++) {
        int idx = (nums[i] - minVal) / bucketSize;
        if (nums[i] < bucketMin[idx]) bucketMin[idx] = nums[i];
        if (nums[i] > bucketMax[idx]) bucketMax[idx] = nums[i];
    }

    int maxGap = 0, prevMax = minVal;
    for (int i = 0; i < bucketCount; i++) {
        if (bucketMin[i] == INT_MAX) continue;
        maxGap = fmax(maxGap, bucketMin[i] - prevMax);
        prevMax = bucketMax[i];
    }

    free(bucketMin);
    free(bucketMax);
    return maxGap;
}