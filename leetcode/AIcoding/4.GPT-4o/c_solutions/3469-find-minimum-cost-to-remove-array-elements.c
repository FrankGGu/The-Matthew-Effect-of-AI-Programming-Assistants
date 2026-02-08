int findMinimumCost(int* nums, int numsSize) {
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    int* freq = (int*)calloc(maxVal + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int* dp = (int*)calloc(maxVal + 1, sizeof(int));
    dp[0] = 0;
    dp[1] = freq[1];

    for (int i = 2; i <= maxVal; i++) {
        dp[i] = fmin(dp[i - 1], dp[i - 2] + i * freq[i]) + freq[i] * i;
    }

    int result = dp[maxVal];
    free(freq);
    free(dp);
    return result;
}