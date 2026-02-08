#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * restoreString(char * s, int* indices, int indicesSize){
    char *result = (char*)malloc(sizeof(char) * (indicesSize + 1));
    if (result == NULL) return NULL;

    for (int i = 0; i < indicesSize; i++) {
        result[indices[i]] = s[i];
    }
    result[indicesSize] = '\0';

    return result;
}