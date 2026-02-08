#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** divideString(char* s, int k, int* returnSize, int** returnColumnSizes) {
    int n = strlen(s);
    int rows = (n + k - 1) / k;
    *returnSize = rows;
    char** result = (char**)malloc(rows * sizeof(char*));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));

    for (int i = 0; i < rows; i++) {
        int len = (i == rows - 1) ? (n - i * k) : k;
        result[i] = (char*)malloc((len + 1) * sizeof(char));
        strncpy(result[i], s + i * k, len);
        result[i][len] = '\0';
        (*returnColumnSizes)[i] = len;
    }

    return result;
}