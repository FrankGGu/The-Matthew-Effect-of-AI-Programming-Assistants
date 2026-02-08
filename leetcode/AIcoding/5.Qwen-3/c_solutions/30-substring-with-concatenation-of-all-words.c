#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findSubstring(char* s, char** words, int wordsSize, int* returnSize) {
    if (wordsSize == 0 || s == NULL || words == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int wordLen = strlen(words[0]);
    int totalWords = wordsSize;
    int totalLen = wordLen * totalWords;
    int sLen = strlen(s);
    int* result = (int*)malloc(sizeof(int) * sLen);
    int index = 0;

    for (int i = 0; i <= sLen - totalLen; i++) {
        int* freq = (int*)calloc(totalWords, sizeof(int));
        int match = 0;
        for (int j = 0; j < totalWords; j++) {
            char* current = (char*)malloc(wordLen + 1);
            strncpy(current, s + i + j * wordLen, wordLen);
            current[wordLen] = '\0';
            int found = -1;
            for (int k = 0; k < totalWords; k++) {
                if (strcmp(current, words[k]) == 0) {
                    found = k;
                    break;
                }
            }
            if (found == -1) {
                free(current);
                break;
            }
            if (freq[found] == 0) {
                match++;
            }
            freq[found]++;
            free(current);
        }
        if (match == totalWords) {
            result[index++] = i;
        }
        free(freq);
    }

    *returnSize = index;
    return result;
}