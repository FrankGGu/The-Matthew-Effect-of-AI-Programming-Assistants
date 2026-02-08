int differenceOfSums(int* nums, int numsSize) {
    int divisibleSum = 0, nonDivisibleSum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 3 == 0) {
            divisibleSum += nums[i];
        } else {
            nonDivisibleSum += nums[i];
        }
    }
    return divisibleSum - nonDivisibleSum;
}