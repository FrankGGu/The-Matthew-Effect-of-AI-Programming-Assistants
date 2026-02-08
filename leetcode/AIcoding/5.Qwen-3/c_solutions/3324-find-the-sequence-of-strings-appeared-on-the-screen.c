#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **stringSequence(int target, int *returnSize) {
    char **result = (char **)malloc(sizeof(char *) * 1000);
    *returnSize = 0;

    char buffer[100];
    for (int i = 1; i <= target; i++) {
        sprintf(buffer, "%d", i);
        result[*returnSize] = (char *)malloc(strlen(buffer) + 1);
        strcpy(result[*returnSize], buffer);
        (*returnSize)++;
    }

    return result;
}