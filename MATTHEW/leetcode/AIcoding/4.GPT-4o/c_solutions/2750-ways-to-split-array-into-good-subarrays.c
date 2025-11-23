int countGoodSubarrays(int* nums, int numsSize) {
    long long total = 0;
    long long prefixSum = 0;
    long long count[100001] = {0};
    count[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        prefixSum += nums[i];
        if (prefixSum >= 100000) prefixSum = 100000; // Cap it to avoid overflow
        total += count[prefixSum];
        count[prefixSum]++;
    }

    return (int)(total % 1000000007);
}