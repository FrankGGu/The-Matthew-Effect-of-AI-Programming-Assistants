int maxAbsoluteSum(int* nums, int numsSize) {
    int maxSum = 0, minSum = 0, currentMax = 0, currentMin = 0;
    for (int i = 0; i < numsSize; i++) {
        currentMax += nums[i];
        currentMin += nums[i];
        if (currentMax < 0) currentMax = 0;
        if (currentMin > 0) currentMin = 0;
        maxSum = fmax(maxSum, currentMax);
        minSum = fmin(minSum, currentMin);
    }
    return fmax(maxSum, -minSum);
}