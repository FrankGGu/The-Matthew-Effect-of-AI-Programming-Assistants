#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **findOcurrences(char *message, char *first, char *second, int *returnSize) {
    int len = strlen(message);
    char **result = (char **)malloc(sizeof(char *));
    *returnSize = 0;
    int capacity = 1;

    char *token = strtok(message, " ");
    char *prev1 = NULL;
    char *prev2 = NULL;

    while (token != NULL) {
        if (prev1 != NULL && prev2 != NULL && strcmp(prev1, first) == 0 && strcmp(prev2, second) == 0) {
            if (*returnSize >= capacity - 1) {
                capacity *= 2;
                result = (char **)realloc(result, capacity * sizeof(char *));
            }
            result[*returnSize] = (char *)malloc(strlen(token) + 1);
            strcpy(result[*returnSize], token);
            (*returnSize)++;
        }
        prev2 = prev1;
        prev1 = token;
        token = strtok(NULL, " ");
    }

    return result;
}