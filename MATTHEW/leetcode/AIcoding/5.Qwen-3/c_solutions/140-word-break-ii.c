#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** wordBreak(char* s, char** wordDict, int wordDictSize, int* returnSize) {
    int n = strlen(s);
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) dp[i] = 0;
    dp[0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < wordDictSize; j++) {
            int len = strlen(wordDict[j]);
            if (i >= len && dp[i - len] && strncmp(s + i - len, wordDict[j], len) == 0) {
                dp[i] = 1;
                break;
            }
        }
    }

    if (!dp[n]) {
        *returnSize = 0;
        return NULL;
    }

    char** result = (char**)malloc(sizeof(char*));
    *returnSize = 0;

    void dfs(char* s, int pos, char* path, int* pathLen, char** wordDict, int wordDictSize, int* returnSize, char*** result) {
        if (pos == strlen(s)) {
            (*result) = (char**)realloc(*result, (*returnSize + 1) * sizeof(char*));
            (*result)[*returnSize] = (char*)malloc((pathLen[0] + 1) * sizeof(char));
            strcpy((*result)[*returnSize], path);
            (*returnSize)++;
            return;
        }

        for (int i = 0; i < wordDictSize; i++) {
            int len = strlen(wordDict[i]);
            if (pos + len <= strlen(s) && strncmp(s + pos, wordDict[i], len) == 0) {
                int newLen = pathLen[0];
                if (newLen > 0) newLen++;
                newLen += len;
                path = (char*)realloc(path, newLen + 1);
                if (pathLen[0] > 0) path[newLen - len - 1] = ' ';
                strncpy(path + newLen - len, wordDict[i], len);
                path[newLen] = '\0';
                pathLen[0] = newLen;
                dfs(s, pos + len, path, pathLen, wordDict, wordDictSize, returnSize, result);
                pathLen[0] = newLen - len;
                if (pathLen[0] > 0) pathLen[0]--;
                path = (char*)realloc(path, pathLen[0] + 1);
            }
        }
    }

    int pathLen = 0;
    char* path = (char*)malloc(1);
    path[0] = '\0';
    dfs(s, 0, path, &pathLen, wordDict, wordDictSize, returnSize, &result);

    free(dp);
    return result;
}