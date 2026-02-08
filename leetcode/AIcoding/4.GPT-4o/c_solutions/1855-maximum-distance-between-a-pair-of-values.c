int maximumGap(int* nums, int numsSize) {
    if (numsSize < 2) return 0;

    int min_val = nums[0], max_val = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min_val) min_val = nums[i];
        if (nums[i] > max_val) max_val = nums[i];
    }

    int bucketSize = fmax(1, (max_val - min_val) / (numsSize - 1));
    int bucketCount = (max_val - min_val) / bucketSize + 1;
    int* bucketMin = (int*)malloc(bucketCount * sizeof(int));
    int* bucketMax = (int*)malloc(bucketCount * sizeof(int));
    for (int i = 0; i < bucketCount; i++) {
        bucketMin[i] = INT_MAX;
        bucketMax[i] = INT_MIN;
    }

    for (int i = 0; i < numsSize; i++) {
        int idx = (nums[i] - min_val) / bucketSize;
        bucketMin[idx] = fmin(bucketMin[idx], nums[i]);
        bucketMax[idx] = fmax(bucketMax[idx], nums[i]);
    }

    int maxGap = 0, prevMax = min_val;
    for (int i = 0; i < bucketCount; i++) {
        if (bucketMin[i] == INT_MAX) continue;
        maxGap = fmax(maxGap, bucketMin[i] - prevMax);
        prevMax = bucketMax[i];
    }

    free(bucketMin);
    free(bucketMax);
    return maxGap;
}