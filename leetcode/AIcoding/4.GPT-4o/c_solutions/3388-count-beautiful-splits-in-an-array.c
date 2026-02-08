int countBeautifulSplits(int* nums, int numsSize) {
    int totalCount = 0;
    int prefixSum[numsSize + 1];
    prefixSum[0] = 0;

    for (int i = 0; i < numsSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    for (int i = 1; i < numsSize; i++) {
        if (prefixSum[i] == (prefixSum[numsSize] - prefixSum[i])) {
            totalCount++;
        }
    }

    return totalCount;
}