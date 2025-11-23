#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

#define MAX_LEN 1000

int minExtraChar(char *s, char **dictionary, int dictSize) {
    int n = strlen(s);
    bool dp[MAX_LEN + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i <= n; i++) {
        dp[i] = i; // Worst case: extra characters are all characters up to i
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < dictSize; j++) {
            int len = strlen(dictionary[j]);
            if (i >= len && strncmp(s + i - len, dictionary[j], len) == 0) {
                dp[i] = dp[i] < dp[i - len] ? dp[i] : dp[i - len];
            }
        }
        dp[i]++;
    }

    return dp[n];
}