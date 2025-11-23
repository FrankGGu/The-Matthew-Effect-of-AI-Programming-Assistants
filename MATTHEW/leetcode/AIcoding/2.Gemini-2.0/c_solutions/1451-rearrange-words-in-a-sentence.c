#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strlen(*(char**)a) - strlen(*(char**)b);
}

char * arrangeWords(char * text){
    int len = strlen(text);
    char *copy = (char*)malloc(len + 1);
    strcpy(copy, text);
    copy[0] = tolower(copy[0]);

    int count = 0;
    for (int i = 0; i < len; i++) {
        if (copy[i] == ' ') {
            count++;
        }
    }
    int wordCount = count + 1;
    char **words = (char**)malloc(wordCount * sizeof(char*));
    char *token = strtok(copy, " ");
    int i = 0;
    while (token != NULL) {
        words[i] = token;
        token = strtok(NULL, " ");
        i++;
    }

    qsort(words, wordCount, sizeof(char*), compare);

    int resultLen = 0;
    for (int j = 0; j < wordCount; j++) {
        resultLen += strlen(words[j]);
    }
    resultLen += count; 
    char *result = (char*)malloc(resultLen + 1);
    result[0] = '\0';

    for (int j = 0; j < wordCount; j++) {
        strcat(result, words[j]);
        if (j < wordCount - 1) {
            strcat(result, " ");
        }
    }

    result[0] = toupper(result[0]);
    return result;
}