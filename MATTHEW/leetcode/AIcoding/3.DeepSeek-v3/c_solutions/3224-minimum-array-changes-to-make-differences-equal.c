int minChanges(int* nums, int numsSize, int k) {
    int freq[1024][1024] = {0};
    int group_size[1024] = {0};

    for (int i = 0; i < numsSize; i++) {
        int group = i % k;
        freq[group][nums[i]]++;
        group_size[group]++;
    }

    int dp[1024] = {0};
    for (int i = 0; i < 1024; i++) {
        dp[i] = 2000000000;
    }
    dp[0] = 0;

    for (int i = 0; i < k; i++) {
        int min_dp = 2000000000;
        for (int j = 0; j < 1024; j++) {
            if (dp[j] < min_dp) {
                min_dp = dp[j];
            }
        }

        int new_dp[1024];
        for (int j = 0; j < 1024; j++) {
            new_dp[j] = min_dp + group_size[i];
        }

        for (int j = 0; j < 1024; j++) {
            for (int x = 0; x < 1024; x++) {
                int changes = group_size[i] - freq[i][x];
                new_dp[j ^ x] = new_dp[j ^ x] < dp[j] + changes ? new_dp[j ^ x] : dp[j] + changes;
            }
        }

        for (int j = 0; j < 1024; j++) {
            dp[j] = new_dp[j];
        }
    }

    return dp[0];
}