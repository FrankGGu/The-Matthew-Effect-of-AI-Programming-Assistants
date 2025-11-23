int maximizeSum(int* nums, int numsSize, int k) {
    int maxSum = 0;
    int maxNum = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    for (int i = 0; i < k; i++) {
        maxSum += (maxNum + i) * (maxNum + i);
    }

    return maxSum;
}