#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** splitString(char* s, int k, int* returnSize) {
    int len = strlen(s);
    *returnSize = (len + k - 1) / k;
    char** result = (char**)malloc(*returnSize * sizeof(char*));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = (char*)malloc((k + 1) * sizeof(char));
        strncpy(result[i], s + i * k, k);
        result[i][k] = '\0';
    }
    return result;
}