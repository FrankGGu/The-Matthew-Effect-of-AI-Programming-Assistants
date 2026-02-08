int minOperations(char* s1, char* s2, int x) {
    int n = strlen(s1);
    int diff[n];
    int diffCount = 0;

    for (int i = 0; i < n; i++) {
        if (s1[i] != s2[i]) {
            diff[diffCount++] = i;
        }
    }

    if (diffCount % 2 != 0) {
        return -1;
    }

    if (diffCount == 0) {
        return 0;
    }

    int dp[diffCount + 1];
    dp[0] = 0;

    for (int i = 1; i <= diffCount; i++) {
        if (i % 2 == 0) {
            dp[i] = dp[i - 1];
        } else {
            dp[i] = dp[i - 1] + x;
        }

        if (i >= 2) {
            int cost = diff[i - 1] - diff[i - 2];
            if (dp[i - 2] + cost < dp[i]) {
                dp[i] = dp[i - 2] + cost;
            }
        }
    }

    return dp[diffCount];
}