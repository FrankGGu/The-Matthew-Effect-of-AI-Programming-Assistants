int minArraySum(int* nums, int numsSize) {
    int minSum = 0;
    for (int i = 0; i < numsSize; i++) {
        minSum += nums[i];
    }
    return minSum;
}