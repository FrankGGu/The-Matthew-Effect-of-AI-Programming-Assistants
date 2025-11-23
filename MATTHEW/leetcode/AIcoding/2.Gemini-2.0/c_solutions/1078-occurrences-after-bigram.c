#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** findOcurrences(char * text, char * first, char * second, int* returnSize){
    char ** result = (char **)malloc(sizeof(char *) * 1000);
    *returnSize = 0;

    char * token = strtok(text, " ");
    char * arr[1000];
    int count = 0;
    while (token != NULL) {
        arr[count++] = token;
        token = strtok(NULL, " ");
    }

    for (int i = 0; i < count - 2; i++) {
        if (strcmp(arr[i], first) == 0 && strcmp(arr[i + 1], second) == 0) {
            result[*returnSize] = (char *)malloc(sizeof(char) * (strlen(arr[i + 2]) + 1));
            strcpy(result[*returnSize], arr[i + 2]);
            (*returnSize)++;
        }
    }

    return result;
}