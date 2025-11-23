int maxIncreasingSubarrays(int* nums, int numsSize) {
    if (numsSize < 2) return 0;

    int* dp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
    }

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i-1]) {
            dp[i] = dp[i-1] + 1;
        }
    }

    int maxLen = 0;
    for (int i = 1; i < numsSize; i++) {
        if (dp[i] == 1) continue;

        int left = dp[i-1];
        int right = dp[i];

        if (i - dp[i] >= 0 && nums[i - dp[i] + 1] > nums[i - dp[i]]) {
            left = dp[i-1];
        }

        int len1 = dp[i];
        int len2 = 0;

        if (i - len1 >= 0) {
            len2 = dp[i - len1];
        }

        if (len1 > 0 && len2 > 0) {
            int total = len1 + len2;
            if (total > maxLen) {
                maxLen = total;
            }
        }

        if (i + 1 < numsSize && nums[i+1] > nums[i]) {
            int nextLen = dp[i+1];
            if (len1 > 0 && nextLen > 0) {
                int total = len1 + nextLen;
                if (total > maxLen) {
                    maxLen = total;
                }
            }
        }
    }

    for (int i = 0; i < numsSize - 1; i++) {
        if (dp[i] > 1 && i + 1 < numsSize && dp[i+1] > 1) {
            if (nums[i+1] > nums[i]) {
                int total = dp[i] + dp[i+1];
                if (total > maxLen) {
                    maxLen = total;
                }
            }
        }
    }

    free(dp);
    return maxLen;
}