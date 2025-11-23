char* largestNumber(int* cost, int costSize, int target) {
    int* dp = (int*)malloc((target + 1) * sizeof(int));
    for (int i = 0; i <= target; i++) {
        dp[i] = -1000000;
    }
    dp[0] = 0;

    for (int i = 1; i <= target; i++) {
        for (int j = 0; j < 9; j++) {
            if (i >= cost[j]) {
                dp[i] = (dp[i] > dp[i - cost[j]] + 1) ? dp[i] : dp[i - cost[j]] + 1;
            }
        }
    }

    if (dp[target] < 0) {
        free(dp);
        return "0";
    }

    char* res = (char*)malloc((dp[target] + 1) * sizeof(char));
    int cur = target;
    int idx = 0;

    for (int i = 8; i >= 0; i--) {
        while (cur >= cost[i] && dp[cur] == dp[cur - cost[i]] + 1) {
            res[idx++] = '1' + i;
            cur -= cost[i];
        }
    }
    res[idx] = '\0';
    free(dp);
    return res;
}