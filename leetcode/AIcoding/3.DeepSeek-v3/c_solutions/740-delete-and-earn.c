int deleteAndEarn(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) max_val = nums[i];
    }

    int* points = (int*)calloc(max_val + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        points[nums[i]] += nums[i];
    }

    int* dp = (int*)calloc(max_val + 1, sizeof(int));
    dp[0] = points[0];
    dp[1] = points[1] > points[0] ? points[1] : points[0];

    for (int i = 2; i <= max_val; i++) {
        dp[i] = dp[i-1] > (dp[i-2] + points[i]) ? dp[i-1] : (dp[i-2] + points[i]);
    }

    int result = dp[max_val];
    free(points);
    free(dp);
    return result;
}