int minNumberGame(int* nums, int numsSize) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    for(int i = 0; i < numsSize; i++) {
        dp[i] = nums[i];
    }
    for(int i = numsSize - 2; i >= 0; i -= 2) {
        dp[i] = (dp[i] < dp[i + 1]) ? dp[i] : dp[i + 1];
    }
    for(int i = numsSize - 3; i >= 0; i -= 2) {
        dp[i] = (dp[i] < dp[i + 1]) ? dp[i] : dp[i + 1];
    }
    int result = dp[0];
    free(dp);
    return result;
}