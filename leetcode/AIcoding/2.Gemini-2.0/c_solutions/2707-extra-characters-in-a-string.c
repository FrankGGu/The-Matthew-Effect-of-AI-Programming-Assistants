#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minExtraChar(char * s, char ** dictionary, int dictionarySize){
    int n = strlen(s);
    int *dp = (int *)malloc((n + 1) * sizeof(int));
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + 1;
        for (int j = 0; j < dictionarySize; j++) {
            int len = strlen(dictionary[j]);
            if (i >= len && strncmp(s + i - len, dictionary[j], len) == 0) {
                dp[i] = (dp[i] < dp[i - len]) ? dp[i] : dp[i - len];
            }
        }
    }

    int result = dp[n];
    free(dp);
    return result;
}