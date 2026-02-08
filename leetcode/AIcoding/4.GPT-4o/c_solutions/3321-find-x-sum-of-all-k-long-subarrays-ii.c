int findXSum(int* nums, int numsSize, int k) {
    long long sum = 0;
    long long prefixSum = 0;
    long long mod = 1000000007;
    int* dp = (int*)malloc((numsSize + 1) * sizeof(int));

    for (int i = 0; i <= numsSize; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        prefixSum += nums[i];
        if (i >= k) {
            prefixSum -= nums[i - k];
        }
        if (i >= k - 1) {
            sum = (sum + prefixSum) % mod;
        }
    }

    free(dp);
    return (int)sum;
}