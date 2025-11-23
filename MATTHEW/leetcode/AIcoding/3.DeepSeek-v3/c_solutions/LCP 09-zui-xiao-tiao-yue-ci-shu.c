int minJump(int* jump, int jumpSize) {
    int n = jumpSize;
    int *dp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) dp[i] = n;

    dp[0] = 0;
    int max_reach = 0;

    for (int i = 0; i < n; i++) {
        if (i > max_reach) {
            max_reach = i;
            dp[i] = dp[i-1] + 1;
        }

        int next = i + jump[i];
        if (next >= n) {
            dp[n-1] = fmin(dp[n-1], dp[i] + 1);
        } else {
            dp[next] = fmin(dp[next], dp[i] + 1);
            max_reach = fmax(max_reach, next);
        }
    }

    int result = dp[n-1];
    free(dp);
    return result;
}