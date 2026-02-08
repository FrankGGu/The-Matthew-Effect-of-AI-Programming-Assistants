#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestUnequalAdjacentGroupsSubsequence(char ** words, int wordsSize, int* groups, int groupsSize){
    int n = wordsSize;
    int dp[n];
    for (int i = 0; i < n; i++) {
        dp[i] = 1;
    }

    int maxLen = 1;
    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (groups[i] != groups[j]) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                }
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
        }
    }

    return maxLen;
}