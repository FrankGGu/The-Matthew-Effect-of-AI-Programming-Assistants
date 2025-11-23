#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool wordBreak(char * s, char ** wordDict, int wordDictSize){
    int len = strlen(s);
    bool *dp = (bool*)malloc(sizeof(bool) * (len + 1));
    memset(dp, false, sizeof(bool) * (len + 1));
    dp[0] = true;

    for (int i = 1; i <= len; i++) {
        for (int j = 0; j < i; j++) {
            if (dp[j]) {
                char sub[len + 1];
                strncpy(sub, s + j, i - j);
                sub[i - j] = '\0';

                for (int k = 0; k < wordDictSize; k++) {
                    if (strcmp(sub, wordDict[k]) == 0) {
                        dp[i] = true;
                        break;
                    }
                }
            }
            if (dp[i]) break;
        }
    }

    bool result = dp[len];
    free(dp);
    return result;
}