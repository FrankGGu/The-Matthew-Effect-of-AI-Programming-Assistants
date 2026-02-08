#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** encoded;
    int size;
} EncodedStrings;

EncodedStrings* encode(char** strs, int strsSize) {
    EncodedStrings* result = (EncodedStrings*)malloc(sizeof(EncodedStrings));
    result->size = strsSize;
    result->encoded = (char**)malloc(strsSize * sizeof(char*));
    for (int i = 0; i < strsSize; i++) {
        int len = strlen(strs[i]) + 1;
        result->encoded[i] = (char*)malloc(len * sizeof(char));
        strcpy(result->encoded[i], strs[i]);
    }
    return result;
}

char** decode(EncodedStrings* obj, int* returnSize) {
    *returnSize = obj->size;
    char** result = (char**)malloc(obj->size * sizeof(char*));
    for (int i = 0; i < obj->size; i++) {
        int len = strlen(obj->encoded[i]) + 1;
        result[i] = (char*)malloc(len * sizeof(char));
        strcpy(result[i], obj->encoded[i]);
    }
    return result;
}