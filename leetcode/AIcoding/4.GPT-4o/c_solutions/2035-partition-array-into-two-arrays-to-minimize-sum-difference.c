int minAbsDifference(int* nums, int numsSize) {
    int sum = 0, half, i, j;
    for (i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    half = sum / 2;
    int dp[half + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (i = 0; i < numsSize; i++) {
        for (j = half; j >= nums[i]; j--) {
            dp[j] |= dp[j - nums[i]];
        }
    }

    for (i = half; i >= 0; i--) {
        if (dp[i]) {
            return sum - 2 * i;
        }
    }
    return sum;
}