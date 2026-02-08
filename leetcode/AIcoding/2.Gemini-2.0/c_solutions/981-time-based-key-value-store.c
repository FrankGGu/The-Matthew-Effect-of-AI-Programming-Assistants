#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* key;
    char* value;
    int timestamp;
} Entry;

typedef struct {
    Entry* entries;
    int size;
    int capacity;
} TimeMap;

TimeMap* timeMapCreate() {
    TimeMap* obj = (TimeMap*)malloc(sizeof(TimeMap));
    obj->entries = (Entry*)malloc(sizeof(Entry) * 10);
    obj->size = 0;
    obj->capacity = 10;
    return obj;
}

void timeMapSet(TimeMap* obj, char* key, char* value, int timestamp) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->entries = (Entry*)realloc(obj->entries, sizeof(Entry) * obj->capacity);
    }

    obj->entries[obj->size].key = (char*)malloc(strlen(key) + 1);
    strcpy(obj->entries[obj->size].key, key);

    obj->entries[obj->size].value = (char*)malloc(strlen(value) + 1);
    strcpy(obj->entries[obj->size].value, value);

    obj->entries[obj->size].timestamp = timestamp;
    obj->size++;
}

char* timeMapGet(TimeMap* obj, char* key, int timestamp) {
    char* result = "";
    int left = 0;
    int right = obj->size - 1;

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