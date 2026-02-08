int maxAlternatingSum(int* nums, int numsSize) {
    long long evenSum = 0, oddSum = 0;
    for (int i = 0; i < numsSize; i++) {
        evenSum = fmax(evenSum, oddSum + nums[i]);
        oddSum = fmax(oddSum, evenSum - nums[i]);
    }
    return evenSum;
}