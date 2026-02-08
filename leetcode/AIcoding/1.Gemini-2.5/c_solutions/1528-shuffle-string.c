#include <stdlib.h>
#include <string.h>

char* restoreString(char* s, int* indices, int indicesSize) {
    char* result = (char*)malloc(sizeof(char) * (indicesSize + 1));
    if (result == NULL) {
        return NULL; 
    }
    result[indicesSize] = '\0';

    for (int i = 0; i < indicesSize; i++) {
        result[indices[i]] = s[i];
    }

    return result;
}