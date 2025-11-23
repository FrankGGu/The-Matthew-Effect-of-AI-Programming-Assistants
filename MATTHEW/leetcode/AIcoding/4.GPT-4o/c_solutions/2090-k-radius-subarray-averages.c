int* getAverages(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    long long windowSum = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i < 2 * k + 1) {
            windowSum += nums[i];
            if (i == 2 * k) {
                result[i - k] = windowSum / (2 * k + 1);
            }
        } else {
            windowSum += nums[i] - nums[i - 2 * k - 1];
            result[i - k] = windowSum / (2 * k + 1);
        }
        if (i < k) {
            result[i] = -1;
        }
    }

    for (int i = numsSize - k; i < numsSize; i++) {
        result[i] = -1;
    }

    return result;
}