#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return strlen(*(char **)a) - strlen(*(char **)b);
}

int isPredecessor(char *s1, char *s2) {
    if (strlen(s1) + 1 != strlen(s2)) {
        return 0;
    }
    int i = 0, j = 0;
    int diff = 0;
    while (i < strlen(s1) && j < strlen(s2)) {
        if (s1[i] == s2[j]) {
            i++;
            j++;
        } else {
            diff++;
            j++;
        }
    }
    if (diff > 1) {
        return 0;
    }
    return 1;
}

int longestStrChain(char **words, int wordsSize) {
    qsort(words, wordsSize, sizeof(char *), cmp);
    int dp[wordsSize];
    for (int i = 0; i < wordsSize; i++) {
        dp[i] = 1;
    }
    int maxChain = 1;
    for (int i = 1; i < wordsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (isPredecessor(words[j], words[i])) {
                dp[i] = (dp[i] > dp[j] + 1) ? dp[i] : (dp[j] + 1);
            }
        }
        maxChain = (maxChain > dp[i]) ? maxChain : dp[i];
    }
    return maxChain;
}