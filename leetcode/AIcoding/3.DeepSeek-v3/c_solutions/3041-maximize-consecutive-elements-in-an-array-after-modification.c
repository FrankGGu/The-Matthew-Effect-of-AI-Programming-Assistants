int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxSelectedElements(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int dp[numsSize];
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
    }

    int maxLen = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i-1] + 1) {
            dp[i] = dp[i-1] + 1;
        } else if (nums[i] == nums[i-1]) {
            dp[i] = dp[i-1];
        } else if (nums[i] - 1 == nums[i-1]) {
            dp[i] = dp[i-1] + 1;
        } else if (nums[i] - 2 == nums[i-1]) {
            dp[i] = dp[i-1] + 1;
        } else {
            dp[i] = 1;
        }

        if (dp[i] > maxLen) {
            maxLen = dp[i];
        }
    }

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i-1] + 1) {
            if (dp[i] < dp[i-1] + 1) {
                dp[i] = dp[i-1] + 1;
            }
        }
        if (nums[i] == nums[i-1]) {
            if (dp[i] < dp[i-1]) {
                dp[i] = dp[i-1];
            }
        }
        if (nums[i] - 1 == nums[i-1]) {
            if (dp[i] < dp[i-1] + 1) {
                dp[i] = dp[i-1] + 1;
            }
        }
        if (nums[i] - 2 == nums[i-1]) {
            if (dp[i] < dp[i-1] + 1) {
                dp[i] = dp[i-1] + 1;
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
        }
    }

    return maxLen;
}