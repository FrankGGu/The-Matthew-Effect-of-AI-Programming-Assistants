#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void generate(int n, char *current, int index, char last, char **result, int *returnSize) {
    if (index == n) {
        result[*returnSize] = strdup(current);
        (*returnSize)++;
        return;
    }
    if (last != '0') {
        current[index] = '0';
        generate(n, current, index + 1, '0', result, returnSize);
    }
    current[index] = '1';
    generate(n, current, index + 1, '1', result, returnSize);
}

char **generateBinaryStrings(int n, int *returnSize) {
    char **result = (char **)malloc(sizeof(char *) * (1 << n));
    *returnSize = 0;
    char *current = (char *)malloc((n + 1) * sizeof(char));
    generate(n, current, 0, '0', result, returnSize);
    free(current);
    return result;
}