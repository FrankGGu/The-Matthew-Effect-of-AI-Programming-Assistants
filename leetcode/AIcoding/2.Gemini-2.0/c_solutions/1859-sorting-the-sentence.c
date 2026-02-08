#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *sortSentence(char *s) {
    int len = strlen(s);
    char **words = (char **)malloc(sizeof(char *) * 10);
    for (int i = 0; i < 10; i++) {
        words[i] = (char *)malloc(sizeof(char) * (len + 1));
        words[i][0] = '\0';
    }

    char *token = strtok(s, " ");
    while (token != NULL) {
        int word_len = strlen(token);
        int index = token[word_len - 1] - '0';
        token[word_len - 1] = '\0';
        strcpy(words[index - 1], token);
        token = strtok(NULL, " ");
    }

    char *result = (char *)malloc(sizeof(char) * (len + 1));
    result[0] = '\0';
    for (int i = 0; i < 10; i++) {
        if (words[i][0] != '\0') {
            strcat(result, words[i]);
            strcat(result, " ");
        }
    }

    result[strlen(result) - 1] = '\0';

    for (int i = 0; i < 10; i++) {
        free(words[i]);
    }
    free(words);

    return result;
}