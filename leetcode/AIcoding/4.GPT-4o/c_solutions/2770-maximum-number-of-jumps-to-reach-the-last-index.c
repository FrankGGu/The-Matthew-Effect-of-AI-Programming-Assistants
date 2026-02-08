int maxJumps(int* nums, int numsSize) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = -1;
    }
    dp[0] = 0;

    for (int i = 0; i < numsSize; i++) {
        if (dp[i] == -1) continue;
        for (int jump = 1; jump <= nums[i] && i + jump < numsSize; jump++) {
            if (dp[i + jump] < dp[i] + 1) {
                dp[i + jump] = dp[i] + 1;
            }
        }
    }

    return dp[numsSize - 1];
}