#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void generateHappyStrings(int n, int k, char *current, int index, int *count, char **result) {
    if (index == n) {
        (*count)++;
        if (*count == k) {
            result[0] = strdup(current);
        }
        return;
    }

    for (char c = 'a'; c <= 'c'; c++) {
        if (index == 0 || current[index - 1] != c) {
            current[index] = c;
            generateHappyStrings(n, k, current, index + 1, count, result);
            if (result[0] != NULL) return;
        }
    }
}

char *getHappyString(int n, int k) {
    char *current = (char *)malloc(n + 1);
    current[n] = '\0';
    int count = 0;
    char **result = (char **)malloc(sizeof(char *));
    result[0] = NULL;
    generateHappyStrings(n, k, current, 0, &count, result);
    free(current);
    char *res = result[0];
    free(result);
    return res ? res : "";
}