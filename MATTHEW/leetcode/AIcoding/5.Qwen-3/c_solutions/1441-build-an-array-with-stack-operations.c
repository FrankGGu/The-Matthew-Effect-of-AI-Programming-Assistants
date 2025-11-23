#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **buildArray(int *target, int targetSize, int n, int *returnSize) {
    char **result = (char **)malloc(targetSize * sizeof(char *));
    *returnSize = 0;
    int current = 1;
    for (int i = 0; i < targetSize; i++) {
        while (current < target[i]) {
            result[*returnSize] = (char *)malloc(6 * sizeof(char));
            strcpy(result[*returnSize], "Push");
            (*returnSize)++;
            current++;
        }
        result[*returnSize] = (char *)malloc(6 * sizeof(char));
        strcpy(result[*returnSize], "Push");
        (*returnSize)++;
        current++;
    }
    return result;
}