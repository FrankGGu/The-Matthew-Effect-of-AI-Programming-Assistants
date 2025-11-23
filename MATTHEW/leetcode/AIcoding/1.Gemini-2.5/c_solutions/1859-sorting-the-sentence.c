#include <stdlib.h>
#include <string.h>
#include <stdio.h>

char *sortSentence(char *s) {
    char *words[10];
    int wordCount = 0;
    int len = strlen(s);
    char *temp = (char *)malloc(len + 1);
    strcpy(temp, s);

    char *token = strtok(temp, " ");
    while (token != NULL) {
        int wordLen = strlen(token);
        int index = token[wordLen - 1] - '1';
        token[wordLen - 1] = '\0';
        words[index] = (char *)malloc(wordLen);
        strcpy(words[index], token);
        wordCount++;
        token = strtok(NULL, " ");
    }

    int resultLen = 0;
    for (int i = 0; i < wordCount; i++) {
        resultLen += strlen(words[i]);
        if (i < wordCount - 1) {
            resultLen++;
        }
    }

    char *result = (char *)malloc(resultLen + 1);
    result[0] = '\0';

    for (int i = 0; i < wordCount; i++) {
        strcat(result, words[i]);
        if (i < wordCount - 1) {
            strcat(result, " ");
        }
    }

    for (int i = 0; i < wordCount; i++) {
        free(words[i]);
    }
    free(temp);

    return result;
}