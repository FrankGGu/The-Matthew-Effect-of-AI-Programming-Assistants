int deleteAndEarn(int* nums, int numsSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    int* points = (int*)calloc(maxNum + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        points[nums[i]] += nums[i];
    }

    int* dp = (int*)calloc(maxNum + 1, sizeof(int));
    dp[0] = 0;
    dp[1] = points[1];

    for (int i = 2; i <= maxNum; i++) {
        dp[i] = fmax(dp[i - 1], dp[i - 2] + points[i]);
    }

    int result = dp[maxNum];
    free(points);
    free(dp);

    return result;
}