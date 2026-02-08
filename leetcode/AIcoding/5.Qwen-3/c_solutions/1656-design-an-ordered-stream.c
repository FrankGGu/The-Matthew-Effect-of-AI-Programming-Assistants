#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** data;
    int ptr;
    int size;
} OrderedStream;

OrderedStream* orderedStreamCreate(int n) {
    OrderedStream* obj = (OrderedStream*)malloc(sizeof(OrderedStream));
    obj->data = (char**)malloc(n * sizeof(char*));
    for (int i = 0; i < n; i++) {
        obj->data[i] = NULL;
    }
    obj->ptr = 0;
    obj->size = n;
    return obj;
}

char** orderedStreamInsert(OrderedStream* obj, int idKey, char* value, int* retSize) {
    obj->data[idKey - 1] = value;
    char** result = NULL;
    *retSize = 0;
    while (obj->ptr < obj->size && obj->data[obj->ptr] != NULL) {
        (*retSize)++;
        obj->ptr++;
    }
    if (*retSize > 0) {
        result = (char**)malloc(*retSize * sizeof(char*));
        for (int i = 0; i < *retSize; i++) {
            result[i] = obj->data[i];
        }
    }
    return result;
}

void orderedStreamFree(OrderedStream* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->data[i]);
    }
    free(obj->data);
    free(obj);
}