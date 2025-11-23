#include <stdlib.h>
#include <string.h>

typedef struct {
    char** stream;
    int n;
    int ptr;
} OrderedStream;

OrderedStream* orderedStreamCreate(int n) {
    OrderedStream* obj = (OrderedStream*)malloc(sizeof(OrderedStream));
    obj->n = n;
    obj->ptr = 1;
    obj->stream = (char**)calloc(n, sizeof(char*));
    return obj;
}

char** orderedStreamInsert(OrderedStream* obj, int idKey, char* value, int* retSize) {
    obj->stream[idKey - 1] = strdup(value);

    *retSize = 0;
    char** result = NULL;

    if (idKey == obj->ptr) {
        int count = 0;
        int currentCheckPtr = obj->ptr;
        while (currentCheckPtr <= obj->n && obj->stream[currentCheckPtr - 1] != NULL) {
            count++;
            currentCheckPtr++;
        }

        if (count > 0) {
            result = (char**)malloc(count * sizeof(char*));
            int i = 0;
            while (obj->ptr <= obj->n && obj->stream[obj->ptr - 1] != NULL) {
                result[i++] = obj->stream[obj->ptr - 1];
                obj->ptr++;
            }
            *retSize = count;
        }
    }

    return result;
}

void orderedStreamFree(OrderedStream* obj) {
    if (obj == NULL) {
        return;
    }
    for (int i = 0; i < obj->n; i++) {
        if (obj->stream[i] != NULL) {
            free(obj->stream[i]);
        }
    }
    free(obj->stream);
    free(obj);
}