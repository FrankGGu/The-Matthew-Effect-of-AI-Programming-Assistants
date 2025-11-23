int findMaximumLength(int* nums, int numsSize) {
    long long* prefix = (long long*)malloc((numsSize + 1) * sizeof(long long));
    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    int* dp = (int*)malloc((numsSize + 1) * sizeof(int));
    int* last = (int*)malloc((numsSize + 1) * sizeof(int));
    dp[0] = 0;
    last[0] = 0;

    int j = 0;
    for (int i = 1; i <= numsSize; i++) {
        while (j < i && prefix[i] - prefix[j] >= prefix[j] - prefix[last[j]]) {
            j++;
        }
        dp[i] = dp[j] + 1;
        last[i] = j;
    }

    free(prefix);
    free(dp);
    free(last);

    return dp[numsSize];
}