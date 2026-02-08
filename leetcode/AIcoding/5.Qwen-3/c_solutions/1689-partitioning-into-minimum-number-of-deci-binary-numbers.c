#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** minPartitions(char* n, int* returnSize) {
    int len = strlen(n);
    char** result = (char**)malloc(len * sizeof(char*));
    for (int i = 0; i < len; i++) {
        result[i] = (char*)malloc(2 * sizeof(char));
        result[i][0] = n[i];
        result[i][1] = '\0';
    }
    *returnSize = len;
    return result;
}