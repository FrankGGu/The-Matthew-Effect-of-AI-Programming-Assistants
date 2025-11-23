double findMaxAverage(int* nums, int numsSize, int k) {
    double maxSum = 0, currentSum = 0;
    for (int i = 0; i < k; i++) {
        currentSum += nums[i];
    }
    maxSum = currentSum;
    for (int i = k; i < numsSize; i++) {
        currentSum += nums[i] - nums[i - k];
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }
    return maxSum / k;
}