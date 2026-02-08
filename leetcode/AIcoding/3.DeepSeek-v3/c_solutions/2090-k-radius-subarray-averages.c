/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* getAverages(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    if (k == 0) {
        for (int i = 0; i < numsSize; i++) {
            result[i] = nums[i];
        }
        return result;
    }

    for (int i = 0; i < numsSize; i++) {
        result[i] = -1;
    }

    if (2 * k + 1 > numsSize) {
        return result;
    }

    long long* prefix = (long long*)malloc((numsSize + 1) * sizeof(long long));
    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for (int i = k; i < numsSize - k; i++) {
        long long sum = prefix[i + k + 1] - prefix[i - k];
        result[i] = (int)(sum / (2 * k + 1));
    }

    free(prefix);
    return result;
}