int missingNumber(int* nums, int numsSize) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    long long expected_sum = (long long)numsSize * (numsSize + 1) / 2;
    return (int)(expected_sum - sum);
}