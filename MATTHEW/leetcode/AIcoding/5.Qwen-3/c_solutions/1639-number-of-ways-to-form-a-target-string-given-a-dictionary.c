#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfWays(char** words, int wordsSize, char* target) {
    int n = strlen(target);
    int m = strlen(words[0]);
    int mod = 1000000007;

    int count[26] = {0};
    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < m; j++) {
            count[words[i][j] - 'a']++;
        }
    }

    int dp[n + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int i = 0; i < m; i++) {
        for (int j = n; j > 0; j--) {
            dp[j] = (dp[j] + (long long)dp[j - 1] * count[target[j - 1] - 'a']) % mod;
        }
    }

    return dp[n];
}