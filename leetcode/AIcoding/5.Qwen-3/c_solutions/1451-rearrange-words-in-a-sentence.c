#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* rearrangeWords(char* sentence) {
    int len = strlen(sentence);
    char** words = (char**)malloc(sizeof(char*) * (len + 1));
    int wordCount = 0;
    char* token = strtok(sentence, " ");
    while (token != NULL) {
        words[wordCount++] = token;
        token = strtok(NULL, " ");
    }

    for (int i = 0; i < wordCount; i++) {
        for (int j = i + 1; j < wordCount; j++) {
            if (strlen(words[i]) > strlen(words[j])) {
                char* temp = words[i];
                words[i] = words[j];
                words[j] = temp;
            }
        }
    }

    char* result = (char*)malloc(sizeof(char) * (len + 1));
    strcpy(result, "");
    for (int i = 0; i < wordCount; i++) {
        strcat(result, words[i]);
        if (i != wordCount - 1) {
            strcat(result, " ");
        }
    }

    for (int i = 0; i < wordCount; i++) {
        free(words[i]);
    }
    free(words);

    return result;
}