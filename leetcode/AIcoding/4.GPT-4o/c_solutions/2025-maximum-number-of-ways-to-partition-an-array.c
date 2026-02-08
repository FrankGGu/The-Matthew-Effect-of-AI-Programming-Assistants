int waysToPartition(int* nums, int numsSize) {
    long long totalSum = 0, prefixSum = 0, count = 0;

    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    for (int i = 0; i < numsSize - 1; i++) {
        prefixSum += nums[i];
        if (2 * prefixSum == totalSum) {
            count++;
        }
        if (2 * prefixSum + nums[i + 1] == totalSum) {
            count++;
        }
    }

    return count;
}