int waysToSplitArray(int* nums, int numsSize) {
    long long total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    long long leftSum = 0;
    int count = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        leftSum += nums[i];
        if (leftSum >= total - leftSum) {
            count++;
        }
    }

    return count;
}