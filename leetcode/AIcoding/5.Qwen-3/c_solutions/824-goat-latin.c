#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* toGoatLatin(char* sentence) {
    char* result = (char*)malloc(1);
    *result = '\0';
    int wordCount = 0;
    char* token = strtok(sentence, " ");
    while (token != NULL) {
        wordCount++;
        char* newResult = (char*)realloc(result, strlen(result) + strlen(token) + 2);
        if (!newResult) {
            free(result);
            return NULL;
        }
        result = newResult;
        char firstChar = tolower(token[0]);
        if (firstChar == 'a' || firstChar == 'e' || firstChar == 'i' || firstChar == 'o' || firstChar == 'u') {
            strcat(result, token);
        } else {
            char* temp = (char*)malloc(strlen(token));
            strcpy(temp, token + 1);
            strcat(result, temp);
            free(temp);
            strncat(result, &token[0], 1);
        }
        strcat(result, "ma");
        for (int i = 0; i < wordCount; i++) {
            strcat(result, "a");
        }
        if (token != NULL) {
            strcat(result, " ");
        }
        token = strtok(NULL, " ");
    }
    return result;
}