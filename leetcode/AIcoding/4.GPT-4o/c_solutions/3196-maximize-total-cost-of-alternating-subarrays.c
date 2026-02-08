int maximumAlternatingSum(int* nums, int numsSize) {
    long long even = 0, odd = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            even += nums[i];
            even = fmax(even, odd + nums[i]);
        } else {
            odd += nums[i];
            odd = fmax(odd, even - nums[i]);
        }
    }
    return (int)even;
}