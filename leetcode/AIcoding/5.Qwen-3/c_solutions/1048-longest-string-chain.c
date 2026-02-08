#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strlen(*(char**)a) - strlen(*(char**)b);
}

int longestStrChain(char** words, int wordsSize) {
    qsort(words, wordsSize, sizeof(char*), compare);

    int dp[wordsSize];
    for (int i = 0; i < wordsSize; i++) {
        dp[i] = 1;
    }

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (strlen(words[i]) == strlen(words[j]) + 1) {
                int diff = 0;
                int k = 0, l = 0;
                while (k < strlen(words[j]) && l < strlen(words[i])) {
                    if (words[j][k] == words[i][l]) {
                        k++;
                    }
                    l++;
                }
                if (k == strlen(words[j])) {
                    dp[i] = fmax(dp[i], dp[j] + 1);
                }
            }
        }
    }

    int max = 0;
    for (int i = 0; i < wordsSize; i++) {
        if (dp[i] > max) {
            max = dp[i];
        }
    }
    return max;
}