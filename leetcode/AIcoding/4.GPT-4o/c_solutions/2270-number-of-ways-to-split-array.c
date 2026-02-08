int waysToSplitArray(int* nums, int numsSize) {
    long long totalSum = 0, leftSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    int count = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        leftSum += nums[i];
        if (leftSum >= (totalSum - leftSum)) {
            count++;
        }
    }
    return count;
}