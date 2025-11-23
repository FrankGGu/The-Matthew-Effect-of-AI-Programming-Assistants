int minOperations(int* nums, int numsSize, int target) {
    int dp[10001] = {0};
    dp[0] = 1;
    for (int i = 0; i < numsSize; i++) {
        for (int j = 10000; j >= nums[i]; j--) {
            dp[j] |= dp[j - nums[i]];
        }
    }
    for (int i = 0; i <= target; i++) {
        if (dp[i]) {
            int minOps = 0;
            for (int j = 0; j < numsSize; j++) {
                if ((i & nums[j]) == 0) {
                    minOps++;
                }
            }
            if (i == target) {
                return minOps;
            }
        }
    }
    return -1;
}