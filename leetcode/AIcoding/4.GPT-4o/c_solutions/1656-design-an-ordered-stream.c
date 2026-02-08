typedef struct {
    int* ids;
    int* values;
    int size;
    int index;
} OrderedStream;

OrderedStream* orderedStreamCreate(int n) {
    OrderedStream* os = (OrderedStream*)malloc(sizeof(OrderedStream));
    os->ids = (int*)malloc(n * sizeof(int));
    os->values = (int*)malloc(n * sizeof(int));
    os->size = n;
    os->index = 0;
    return os;
}

void orderedStreamInsert(OrderedStream* obj, int idKey, char* value) {
    obj->ids[idKey - 1] = idKey;
    obj->values[idKey - 1] = value;
}

char** orderedStreamFetch(OrderedStream* obj, int* returnSize) {
    int startIndex = obj->index;
    while (obj->index < obj->size && obj->ids[obj->index] > 0) {
        obj->index++;
    }

    int count = obj->index - startIndex;
    char** result = (char**)malloc(count * sizeof(char*));
    *returnSize = count;

    for (int i = 0; i < count; i++) {
        result[i] = obj->values[startIndex + i];
    }

    return result;
}

void orderedStreamFree(OrderedStream* obj) {
    free(obj->ids);
    free(obj->values);
    free(obj);
}