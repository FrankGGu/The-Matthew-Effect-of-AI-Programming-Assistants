#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* sortString(char* s) {
    int len = strlen(s);
    char* sorted = (char*)malloc(len + 1);
    strcpy(sorted, s);
    for (int i = 0; i < len - 1; i++) {
        for (int j = i + 1; j < len; j++) {
            if (sorted[i] > sorted[j]) {
                char temp = sorted[i];
                sorted[i] = sorted[j];
                sorted[j] = temp;
            }
        }
    }
    sorted[len] = '\0';
    return sorted;
}

char** removeAnagrams(char** words, int wordsSize, int* returnSize) {
    char** result = (char**)malloc(wordsSize * sizeof(char*));
    *returnSize = 0;

    if (wordsSize == 0) return result;

    char* prevSorted = sortString(words[0]);
    result[(*returnSize)++] = words[0];

    for (int i = 1; i < wordsSize; i++) {
        char* currSorted = sortString(words[i]);
        if (strcmp(currSorted, prevSorted) != 0) {
            result[(*returnSize)++] = words[i];
        }
        free(prevSorted);
        prevSorted = currSorted;
    }

    free(prevSorted);
    return result;
}