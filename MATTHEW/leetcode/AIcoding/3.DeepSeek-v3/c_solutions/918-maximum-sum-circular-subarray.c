int maxSubarraySumCircular(int* nums, int numsSize) {
    int total = 0, maxSum = nums[0], curMax = 0, minSum = nums[0], curMin = 0;

    for (int i = 0; i < numsSize; i++) {
        curMax = (curMax > 0 ? curMax : 0) + nums[i];
        maxSum = (curMax > maxSum ? curMax : maxSum);
        curMin = (curMin < 0 ? curMin : 0) + nums[i];
        minSum = (curMin < minSum ? curMin : minSum);
        total += nums[i];
    }

    return maxSum > 0 ? (maxSum > total - minSum ? maxSum : total - minSum) : maxSum;
}