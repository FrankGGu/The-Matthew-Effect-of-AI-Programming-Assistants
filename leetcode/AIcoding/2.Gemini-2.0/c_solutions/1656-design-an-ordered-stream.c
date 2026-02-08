#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** stream;
    int ptr;
    int size;
} OrderedStream;

OrderedStream* orderedStreamCreate(int n) {
    OrderedStream* obj = (OrderedStream*)malloc(sizeof(OrderedStream));
    obj->stream = (char**)malloc(sizeof(char*) * (n + 1));
    for (int i = 0; i <= n; i++) {
        obj->stream[i] = NULL;
    }
    obj->ptr = 1;
    obj->size = n;
    return obj;
}

char** orderedStreamInsert(OrderedStream* obj, int idKey, char* value, int* retSize) {
    obj->stream[idKey] = value;

    int count = 0;
    int start = obj->ptr;

    while (obj->ptr <= obj->size && obj->stream[obj->ptr] != NULL) {
        count++;
        obj->ptr++;
    }

    char** result = (char**)malloc(sizeof(char*) * count);
    for (int i = 0; i < count; i++) {
        result[i] = obj->stream[start + i];
    }

    *retSize = count;
    return result;
}

void orderedStreamFree(OrderedStream* obj) {
    for (int i = 1; i <= obj->size; i++) {
        if (obj->stream[i] != NULL) {
            free(obj->stream[i]);
        }
    }
    free(obj->stream);
    free(obj);
}