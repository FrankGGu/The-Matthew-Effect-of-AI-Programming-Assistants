#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* sortSentence(char* s) {
    char* words[100];
    int wordCount = 0;
    char* token = strtok(s, " ");
    while (token != NULL) {
        words[wordCount++] = token;
        token = strtok(NULL, " ");
    }

    char* result = (char*)malloc(1000 * sizeof(char));
    int resultIndex = 0;

    for (int i = 0; i < wordCount; i++) {
        int number = 0;
        char* numStr = strchr(words[i], '0');
        if (numStr != NULL) {
            number = atoi(numStr);
        }
        char* word = (char*)malloc(100 * sizeof(char));
        strncpy(word, words[i], numStr - words[i]);
        word[numStr - words[i]] = '\0';

        int pos = number - 1;
        char* temp = (char*)malloc(100 * sizeof(char));
        sprintf(temp, "%s ", word);
        int j = 0;
        while (j < resultIndex) {
            if (j == pos) {
                strcat(result, temp);
                break;
            }
            j++;
        }
        if (j == resultIndex) {
            strcat(result, temp);
        }
        free(word);
        free(temp);
    }

    result[resultIndex - 1] = '\0';
    return result;
}