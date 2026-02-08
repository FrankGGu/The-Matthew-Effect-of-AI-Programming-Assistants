#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findWordsContaining(char** words, int wordsSize, char x, int* returnSize) {
    int* result = (int*)malloc(wordsSize * sizeof(int));
    *returnSize = 0;
    for (int i = 0; i < wordsSize; i++) {
        if (strchr(words[i], x) != NULL) {
            result[(*returnSize)++] = i;
        }
    }
    return result;
}