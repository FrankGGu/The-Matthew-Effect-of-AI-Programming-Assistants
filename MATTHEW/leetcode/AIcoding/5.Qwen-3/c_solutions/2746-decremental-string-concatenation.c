#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* cat(const char* a, const char* b) {
    int len = strlen(a) + strlen(b);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    strcpy(result, a);
    strcat(result, b);
    return result;
}

char* minimizeConcatenation(char** words, int wordsSize) {
    char* result = (char*)malloc(sizeof(char));
    result[0] = '\0';

    for (int i = 0; i < wordsSize; i++) {
        char* temp = cat(result, words[i]);
        free(result);
        result = temp;
    }

    return result;
}