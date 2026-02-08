#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** findSubstringInWrapAll(char* s, char** words, int wordsSize, int* returnSize) {
    int len = strlen(s);
    int* dp = (int*)calloc(len, sizeof(int));
    int maxLen = 0;
    for (int i = 0; i < len; i++) {
        if (i == 0 || (s[i] - s[i-1] == 1)) {
            dp[i] = (i == 0) ? 1 : dp[i-1] + 1;
        } else {
            dp[i] = 1;
        }
        maxLen = (dp[i] > maxLen) ? dp[i] : maxLen;
    }

    int* patternMap = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < len; i++) {
        int idx = s[i] - 'a';
        if (patternMap[idx] < dp[i]) {
            patternMap[idx] = dp[i];
        }
    }

    char** result = (char**)malloc(wordsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        int wordLen = strlen(words[i]);
        int lastChar = words[i][wordLen - 1] - 'a';
        if (patternMap[lastChar] >= wordLen) {
            result[*returnSize] = strdup(words[i]);
            (*returnSize)++;
        }
    }

    free(dp);
    free(patternMap);
    return result;
}