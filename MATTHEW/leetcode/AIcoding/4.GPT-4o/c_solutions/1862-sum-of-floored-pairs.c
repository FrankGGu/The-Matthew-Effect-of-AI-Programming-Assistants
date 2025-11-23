int sumOfFlooredPairs(int* nums, int numsSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    long long* count = (long long*)calloc(maxNum + 1, sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    long long* prefixSum = (long long*)calloc(maxNum + 1, sizeof(long long));
    for (int i = 1; i <= maxNum; i++) {
        prefixSum[i] = prefixSum[i - 1] + count[i];
    }

    long long result = 0;
    for (int i = 1; i <= maxNum; i++) {
        if (count[i] > 0) {
            result += count[i] * (prefixSum[maxNum / i] - prefixSum[(i - 1) / i]);
        }
    }

    free(count);
    free(prefixSum);
    return result;
}