int minPositiveSum(int* nums, int numsSize) {
    int minSum = 0;
    int currentSum = 0;
    int foundPositive = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            foundPositive = 1;
            currentSum += nums[i];
        } else {
            if (currentSum > 0) {
                minSum += currentSum;
                currentSum = 0;
            }
        }
    }
    if (currentSum > 0) {
        minSum += currentSum;
    }

    return foundPositive ? minSum : 0;
}