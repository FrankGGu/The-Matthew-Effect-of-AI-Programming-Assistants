int sumOfDigitDifferences(int* nums, int numsSize) {
    long long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (i != j) {
                totalSum += abs(nums[i] - nums[j]);
            }
        }
    }
    return totalSum;
}