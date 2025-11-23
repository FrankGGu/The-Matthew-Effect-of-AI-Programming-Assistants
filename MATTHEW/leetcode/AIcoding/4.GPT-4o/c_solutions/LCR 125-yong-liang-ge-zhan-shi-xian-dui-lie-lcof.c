int minOperations(int* nums, int numsSize) {
    int max_len = 0;
    int* dp = (int*)calloc(numsSize, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                dp[i] = fmax(dp[i], dp[j] + 1);
            }
        }
        max_len = fmax(max_len, dp[i]);
    }

    free(dp);
    return numsSize - max_len;
}