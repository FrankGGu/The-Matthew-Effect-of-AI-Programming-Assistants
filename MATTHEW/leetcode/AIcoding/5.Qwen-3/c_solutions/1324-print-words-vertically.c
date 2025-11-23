#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** printWordsVertically(char** words, int wordsSize, int* returnSize) {
    int maxLen = 0;
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        if (len > maxLen) maxLen = len;
    }

    char** result = (char**)malloc(maxLen * sizeof(char*));
    *returnSize = maxLen;

    for (int i = 0; i < maxLen; i++) {
        int len = 0;
        for (int j = 0; j < wordsSize; j++) {
            if (i < strlen(words[j])) len++;
        }
        result[i] = (char*)malloc((len + 1) * sizeof(char));
        int k = 0;
        for (int j = 0; j < wordsSize; j++) {
            if (i < strlen(words[j])) {
                result[i][k++] = words[j][i];
            }
        }
        result[i][k] = '\0';
    }

    return result;
}