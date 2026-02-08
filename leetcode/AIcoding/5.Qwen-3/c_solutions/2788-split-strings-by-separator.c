#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** splitWordsBySeparator(char* words, char separator, int* returnSize) {
    int wordCount = 0;
    int wordLength = 0;
    int i = 0;
    char* currentWord = NULL;
    char** result = NULL;

    while (words[i] != '\0') {
        if (words[i] == separator) {
            if (wordLength > 0) {
                currentWord = (char*)malloc((wordLength + 1) * sizeof(char));
                strncpy(currentWord, words + (i - wordLength), wordLength);
                currentWord[wordLength] = '\0';
                result = (char**)realloc(result, (wordCount + 1) * sizeof(char*));
                result[wordCount++] = currentWord;
                wordLength = 0;
            }
        } else {
            wordLength++;
        }
        i++;
    }

    if (wordLength > 0) {
        currentWord = (char*)malloc((wordLength + 1) * sizeof(char));
        strncpy(currentWord, words + (i - wordLength), wordLength);
        currentWord[wordLength] = '\0';
        result = (char**)realloc(result, (wordCount + 1) * sizeof(char*));
        result[wordCount++] = currentWord;
    }

    *returnSize = wordCount;
    return result;
}