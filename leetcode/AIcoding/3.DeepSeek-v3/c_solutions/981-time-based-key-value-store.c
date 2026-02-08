typedef struct {
    char* key;
    int timestamp;
    char* value;
} TimeMapEntry;

typedef struct {
    TimeMapEntry* entries;
    int size;
    int capacity;
} TimeMap;

TimeMap* timeMapCreate() {
    TimeMap* obj = (TimeMap*)malloc(sizeof(TimeMap));
    obj->size = 0;
    obj->capacity = 10000;
    obj->entries = (TimeMapEntry*)malloc(sizeof(TimeMapEntry) * obj->capacity);
    return obj;
}

void timeMapSet(TimeMap* obj, char* key, char* value, int timestamp) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->entries = (TimeMapEntry*)realloc(obj->entries, sizeof(TimeMapEntry) * obj->capacity);
    }
    obj->entries[obj->size].key = strdup(key);
    obj->entries[obj->size].value = strdup(value);
    obj->entries[obj->size].timestamp = timestamp;
    obj->size++;
}

char* timeMapGet(TimeMap* obj, char* key, int timestamp) {
    int left = 0, right = obj->size - 1;
    char* result = "";

    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (strcmp(obj->entries[mid].key, key) == 0) {
            if (obj->entries[mid].timestamp <= timestamp) {
                result = obj->entries[mid].value;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        } else if (strcmp(obj->entries[mid].key, key) < 0) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}

void timeMapFree(TimeMap* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->entries[i].key);
        free(obj->entries[i].value);
    }
    free(obj->entries);
    free(obj);
}