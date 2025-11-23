#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* word;
    int len;
} Word;

int compare(const void* a, const void* b) {
    return ((Word*)a)->len - ((Word*)b)->len;
}

int isConcatenated(char* word, char** words, int wordsSize, int* dp) {
    int n = strlen(word);
    if (dp[n] != -1) return dp[n];

    for (int i = 1; i < n; i++) {
        if (dp[i] == 1 && strchr(words[i], word[i])) {
            char temp = word[i];
            word[i] = '\0';
            int found = 0;
            for (int j = 0; j < wordsSize; j++) {
                if (strcmp(word, words[j]) == 0) {
                    found = 1;
                    break;
                }
            }
            word[i] = temp;
            if (found && isConcatenated(word + i + 1, words, wordsSize, dp)) {
                dp[n] = 1;
                return 1;
            }
        }
    }
    dp[n] = 0;
    return 0;
}

char** findAllConcatenatedWordsInADictionary(char** words, int wordsSize, int* returnSize) {
    Word* sortedWords = (Word*)malloc(wordsSize * sizeof(Word));
    for (int i = 0; i < wordsSize; i++) {
        sortedWords[i].word = words[i];
        sortedWords[i].len = strlen(words[i]);
    }
    qsort(sortedWords, wordsSize, sizeof(Word), compare);

    char** result = (char**)malloc(wordsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        int maxLen = 0;
        for (int j = 0; j < wordsSize; j++) {
            if (i != j) {
                maxLen = (maxLen < strlen(sortedWords[j].word)) ? strlen(sortedWords[j].word) : maxLen;
            }
        }

        int* dp = (int*)malloc((maxLen + 1) * sizeof(int));
        for (int k = 0; k <= maxLen; k++) {
            dp[k] = -1;
        }

        dp[0] = 1;
        int isConcat = 0;
        for (int j = 0; j < wordsSize; j++) {
            if (i != j) {
                int len = strlen(sortedWords[j].word);
                for (int k = 0; k <= maxLen - len; k++) {
                    if (dp[k] == 1 && strstr(words[i], sortedWords[j].word)) {
                        dp[k + len] = 1;
                    }
                }
            }
        }

        if (dp[strlen(words[i])] == 1) {
            result[*returnSize] = words[i];
            (*returnSize)++;
        }

        free(dp);
    }

    free(sortedWords);
    return result;
}