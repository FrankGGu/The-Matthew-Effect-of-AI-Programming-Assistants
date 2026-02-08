int minHumidity(int n, int* a) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += a[i];
    }

    int half = (sum + 1) / 2;
    int* dp = (int*)malloc((half + 1) * sizeof(int));
    for (int i = 0; i <= half; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 0; i < n; i++) {
        for (int j = half; j >= a[i]; j--) {
            if (dp[j - a[i]]) {
                dp[j] = 1;
            }
        }
    }

    int max_sum = 0;
    for (int j = half; j >= 0; j--) {
        if (dp[j]) {
            max_sum = j;
            break;
        }
    }

    free(dp);
    return sum - 2 * max_sum;
}