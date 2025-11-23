int minStartValue(int* nums, int numsSize) {
    int minSum = 0, currentSum = 0;

    for (int i = 0; i < numsSize; i++) {
        currentSum += nums[i];
        if (currentSum < minSum) {
            minSum = currentSum;
        }
    }

    return 1 - minSum;
}