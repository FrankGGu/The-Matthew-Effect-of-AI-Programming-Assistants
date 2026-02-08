int minimumSubstringsInPartition(char* s) {
    int n = strlen(s);
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = n;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        int count[26] = {0};
        int maxFreq = 0;
        int distinct = 0;

        for (int j = i; j < n; j++) {
            int idx = s[j] - 'a';
            if (count[idx] == 0) distinct++;
            count[idx]++;
            if (count[idx] > maxFreq) maxFreq = count[idx];

            int len = j - i + 1;
            if (len % distinct == 0 && len / distinct == maxFreq) {
                if (dp[j + 1] > dp[i] + 1) {
                    dp[j + 1] = dp[i] + 1;
                }
            }
        }
    }

    return dp[n];
}