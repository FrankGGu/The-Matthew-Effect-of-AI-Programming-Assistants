typedef struct {
    char** stream;
    int size;
    int ptr;
} OrderedStream;

OrderedStream* orderedStreamCreate(int n) {
    OrderedStream* obj = (OrderedStream*)malloc(sizeof(OrderedStream));
    obj->stream = (char**)malloc(n * sizeof(char*));
    obj->size = n;
    obj->ptr = 0;
    for (int i = 0; i < n; i++) {
        obj->stream[i] = NULL;
    }
    return obj;
}

char** orderedStreamInsert(OrderedStream* obj, int idKey, char* value, int* retSize) {
    idKey--;
    obj->stream[idKey] = value;

    *retSize = 0;
    if (idKey != obj->ptr) {
        return NULL;
    }

    int start = obj->ptr;
    while (obj->ptr < obj->size && obj->stream[obj->ptr] != NULL) {
        obj->ptr++;
    }

    *retSize = obj->ptr - start;
    char** result = (char**)malloc((*retSize) * sizeof(char*));
    for (int i = 0; i < *retSize; i++) {
        result[i] = obj->stream[start + i];
    }
    return result;
}

void orderedStreamFree(OrderedStream* obj) {
    free(obj->stream);
    free(obj);
}