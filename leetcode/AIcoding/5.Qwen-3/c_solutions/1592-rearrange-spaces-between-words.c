#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reorderSpaces(char* text) {
    int wordCount = 0;
    int totalSpaces = 0;
    int wordLen = 0;
    char** words = NULL;
    char* result = NULL;
    int i = 0;

    while (text[i] != '\0') {
        if (text[i] == ' ') {
            totalSpaces++;
        } else {
            wordLen++;
        }
        i++;
    }

    i = 0;
    while (text[i] != '\0') {
        if (text[i] == ' ') {
            if (wordLen > 0) {
                words = realloc(words, sizeof(char*) * (wordCount + 1));
                words[wordCount] = malloc(wordLen + 1);
                strncpy(words[wordCount], text + i - wordLen, wordLen);
                words[wordCount][wordLen] = '\0';
                wordCount++;
                wordLen = 0;
            }
        } else {
            wordLen++;
        }
        i++;
    }

    if (wordLen > 0) {
        words = realloc(words, sizeof(char*) * (wordCount + 1));
        words[wordCount] = malloc(wordLen + 1);
        strncpy(words[wordCount], text + i - wordLen, wordLen);
        words[wordCount][wordLen] = '\0';
        wordCount++;
    }

    if (wordCount == 1) {
        result = malloc(totalSpaces + strlen(words[0]) + 1);
        strcpy(result, words[0]);
        for (i = 0; i < totalSpaces; i++) {
            result[strlen(result)] = ' ';
        }
        for (i = 0; i < wordCount; i++) {
            free(words[i]);
        }
        free(words);
        return result;
    }

    int spacesBetween = totalSpaces / (wordCount - 1);
    int extraSpaces = totalSpaces % (wordCount - 1);

    int resultLen = 0;
    for (i = 0; i < wordCount; i++) {
        resultLen += strlen(words[i]);
    }
    resultLen += totalSpaces;

    result = malloc(resultLen + 1);
    result[0] = '\0';

    for (i = 0; i < wordCount; i++) {
        strcat(result, words[i]);
        if (i < wordCount - 1) {
            for (int j = 0; j < spacesBetween; j++) {
                strcat(result, " ");
            }
            if (extraSpaces > 0) {
                strcat(result, " ");
                extraSpaces--;
            }
        }
    }

    for (i = 0; i < wordCount; i++) {
        free(words[i]);
    }
    free(words);

    return result;
}