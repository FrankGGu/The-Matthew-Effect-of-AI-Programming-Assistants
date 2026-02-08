#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LEN 1001

int minNumberOfStrings(char **strings, int stringsSize, char *target) {
    int targetCount[26] = {0};
    for (int i = 0; target[i]; i++) {
        targetCount[target[i] - 'a']++;
    }

    int dp[MAX_LEN];
    memset(dp, 0x3f, sizeof(dp));
    dp[0] = 0;

    for (int i = 0; i < stringsSize; i++) {
        int count[26] = {0};
        for (int j = 0; strings[i][j]; j++) {
            count[strings[i][j] - 'a']++;
        }
        for (int j = MAX_LEN - 1; j >= 0; j--) {
            if (dp[j] < MAX_LEN) {
                int newCount = dp[j];
                for (int k = 0; k < 26; k++) {
                    if (targetCount[k] > 0) {
                        newCount += (targetCount[k] + count[k] - 1) / count[k];
                    }
                }
                dp[newCount] = newCount < dp[newCount] ? newCount : dp[newCount];
            }
        }
    }

    int result = MAX_LEN;
    for (int i = 0; i < MAX_LEN; i++) {
        if (dp[i] < MAX_LEN) {
            result = result < dp[i] ? result : dp[i];
        }
    }
    return result == MAX_LEN ? -1 : result;
}