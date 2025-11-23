int minCost(int* nums, int numsSize, int k) {
    int n = numsSize;
    int dp[n + 1];
    for (int i = 0; i <= n; i++) dp[i] = INT_MAX;
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        int freq[n];
        for (int j = 0; j < n; j++) freq[j] = 0;
        int trimmed = 0;

        for (int j = i - 1; j >= 0; j--) {
            int num = nums[j];
            freq[num]++;
            if (freq[num] == 2) {
                trimmed += 2;
            } else if (freq[num] > 2) {
                trimmed += 1;
            }

            int cost = k + trimmed;
            if (dp[j] != INT_MAX) {
                if (dp[i] > dp[j] + cost) {
                    dp[i] = dp[j] + cost;
                }
            }
        }
    }

    return dp[n];
}