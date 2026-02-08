#include <string.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maximizeTheNumberOfPartitions(char * s, int k){
    int n = strlen(s);

    int dp[n + 1][2];
    for (int i = 0; i <= n; ++i) {
        dp[i][0] = -1;
        dp[i][1] = -1;
    }

    dp[0][0] = 0;
    dp[0][1] = 0;

    for (int i = 1; i <= n; ++i) {
        int freq[26] = {0};
        int distinct_count = 0;

        for (int j = i - 1; j >= 0; --j) {
            if (freq[s[j] - 'a'] == 0) {
                distinct_count++;
            }
            freq[s[j] - 'a']++;

            if (dp[j][0] != -1) {
                if (distinct_count <= k) {
                    dp[i][0] = max(dp[i][0], dp[j][0] + 1);
                }
                if (distinct_count <= k + 1) {
                    dp[i][1] = max(dp[i][1], dp[j][0] + 1);
                }
            }

            if (dp[j][1] != -1) {
                if (distinct_count <= k) {
                    dp[i][1] = max(dp[i][1], dp[j][1] + 1);
                }
            }
        }
    }

    return max(dp[n][0], dp[n][1]);
}