int racecar(int target) {
    int *dp = (int*)malloc((target + 1) * sizeof(int));
    for (int i = 0; i <= target; i++) {
        dp[i] = INT_MAX;
    }

    dp[0] = 0;
    for (int i = 1; i <= target; i++) {
        int k = 1;
        int pos = 1;

        while (pos < i) {
            int j = 0;
            int back = 0;
            while (j < pos) {
                dp[i] = fmin(dp[i], k + 1 + 1 + j + dp[i - (pos - back)]);
                j = (1 << ++back) - 1;
            }
            k++;
            pos = (1 << k) - 1;
        }

        if (pos == i) {
            dp[i] = k;
        } else {
            dp[i] = fmin(dp[i], k + 1 + dp[pos - i]);
        }
    }

    int result = dp[target];
    free(dp);
    return result;
}