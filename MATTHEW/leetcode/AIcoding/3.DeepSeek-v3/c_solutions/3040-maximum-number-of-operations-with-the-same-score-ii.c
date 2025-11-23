int maxOperations(int* nums, int numsSize) {
    if (numsSize < 2) return 0;

    int (*dp)[numsSize];
    dp = malloc(numsSize * sizeof(*dp));
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            dp[i][j] = 0;
        }
    }

    int max = 0;

    int targets[3] = {
        nums[0] + nums[1],
        nums[0] + nums[numsSize - 1],
        nums[numsSize - 2] + nums[numsSize - 1]
    };

    for (int t = 0; t < 3; t++) {
        int target = targets[t];
        for (int i = numsSize - 1; i >= 0; i--) {
            for (int j = i + 1; j < numsSize; j++) {
                if (j - i + 1 < 2) {
                    dp[i][j] = 0;
                    continue;
                }

                int res = 0;
                if (nums[i] + nums[i + 1] == target) {
                    res = fmax(res, (i + 2 <= j ? dp[i + 2][j] : 0) + 1);
                }
                if (nums[i] + nums[j] == target) {
                    res = fmax(res, (i + 1 <= j - 1 ? dp[i + 1][j - 1] : 0) + 1);
                }
                if (nums[j - 1] + nums[j] == target) {
                    res = fmax(res, (i <= j - 2 ? dp[i][j - 2] : 0) + 1);
                }
                dp[i][j] = res;
            }
        }
        if (dp[0][numsSize - 1] > max) {
            max = dp[0][numsSize - 1];
        }
    }

    free(dp);
    return max;
}