#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findSubstring(char * s, char ** words, int wordsSize, int* returnSize){
    int sLen = strlen(s);
    if (sLen == 0 || wordsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int wordLen = strlen(words[0]);
    int totalLen = wordLen * wordsSize;
    if (sLen < totalLen) {
        *returnSize = 0;
        return NULL;
    }

    int *result = (int*)malloc(sizeof(int) * sLen);
    *returnSize = 0;

    int *wordCounts = (int*)malloc(sizeof(int) * wordsSize);
    for (int i = 0; i < wordsSize; i++) {
        wordCounts[i] = 1;
    }

    for (int i = 0; i <= sLen - totalLen; i++) {
        int *seen = (int*)calloc(wordsSize, sizeof(int));
        int matchCount = 0;
        for (int j = 0; j < wordsSize; j++) {
            int k;
            for (k = 0; k < wordsSize; k++) {
                if (seen[k] == 0 && strncmp(s + i + j * wordLen, words[k], wordLen) == 0) {
                    seen[k] = 1;
                    matchCount++;
                    break;
                }
            }
            if (k == wordsSize) {
                break;
            }
        }

        if (matchCount == wordsSize) {
            result[(*returnSize)++] = i;
        }
        free(seen);
    }

    free(wordCounts);
    return result;
}