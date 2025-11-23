int minChanges(int* nums, int numsSize, int k) {
    int n = numsSize;
    int MAX = 1024;
    int dp[k][MAX];
    int g[k];

    for (int i = 0; i < k; i++) {
        for (int j = 0; j < MAX; j++) {
            dp[i][j] = n + 1;
        }
        g[i] = n + 1;
    }

    for (int i = 0; i < k; i++) {
        int cnt = 0;
        int freq[MAX] = {0};
        for (int j = i; j < n; j += k) {
            freq[nums[j]]++;
            cnt++;
        }

        if (i == 0) {
            for (int x = 0; x < MAX; x++) {
                dp[0][x] = cnt - freq[x];
                g[0] = fmin(g[0], dp[0][x]);
            }
        } else {
            for (int x = 0; x < MAX; x++) {
                dp[i][x] = g[i-1] + cnt;
                for (int j = i; j < n; j += k) {
                    int num = nums[j];
                    dp[i][x] = fmin(dp[i][x], dp[i-1][x ^ num] + cnt - freq[num]);
                }
                g[i] = fmin(g[i], dp[i][x]);
            }
        }
    }

    return dp[k-1][0];
}