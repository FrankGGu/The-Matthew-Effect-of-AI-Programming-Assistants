int maxAscendingSum(int* nums, int numsSize) {
    int maxSum = 0, currentSum = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i == 0 || nums[i] > nums[i - 1]) {
            currentSum += nums[i];
        } else {
            if (currentSum > maxSum) {
                maxSum = currentSum;
            }
            currentSum = nums[i];
        }
    }

    if (currentSum > maxSum) {
        maxSum = currentSum;
    }

    return maxSum;
}