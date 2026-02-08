#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int timestamp;
    char *value;
} KeyValuePair;

typedef struct {
    char *key;
    KeyValuePair *values;
    int size;
    int capacity;
} KeyStore;

typedef struct {
    KeyStore *store;
    int size;
    int capacity;
} TimeMap;

TimeMap* timeMapCreate() {
    TimeMap *obj = (TimeMap*)malloc(sizeof(TimeMap));
    obj->size = 0;
    obj->capacity = 1;
    obj->store = (KeyStore*)malloc(obj->capacity * sizeof(KeyStore));
    return obj;
}

void timeMapSet(TimeMap* obj, char *key, char *value, int timestamp) {
    int i;
    for (i = 0; i < obj->size; i++) {
        if (strcmp(obj->store[i].key, key) == 0) {
            break;
        }
    }
    if (i == obj->size) {
        if (obj->size == obj->capacity) {
            obj->capacity *= 2;
            obj->store = (KeyStore*)realloc(obj->store, obj->capacity * sizeof(KeyStore));
        }
        obj->store[i].key = strdup(key);
        obj->store[i].size = 0;
        obj->store[i].capacity = 1;
        obj->store[i].values = (KeyValuePair*)malloc(obj->store[i].capacity * sizeof(KeyValuePair));
        obj->size++;
    }
    if (obj->store[i].size == obj->store[i].capacity) {
        obj->store[i].capacity *= 2;
        obj->store[i].values = (KeyValuePair*)realloc(obj->store[i].values, obj->store[i].capacity * sizeof(KeyValuePair));
    }
    obj->store[i].values[obj->store[i].size].key = strdup(key);
    obj->store[i].values[obj->store[i].size].timestamp = timestamp;
    obj->store[i].values[obj->store[i].size].value = strdup(value);
    obj->store[i].size++;
}

char* timeMapGet(TimeMap* obj, char *key, int timestamp) {
    for (int i = 0; i < obj->size; i++) {
        if (strcmp(obj->store[i].key, key) == 0) {
            int left = 0;
            int right = obj->store[i].size - 1;
            int res = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (obj->store[i].values[mid].timestamp <= timestamp) {
                    res = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            if (res == -1) {
                return "";
            }
            return obj->store[i].values[res].value;
        }
    }
    return "";
}

void timeMapFree(TimeMap* obj) {
    for (int i = 0; i < obj->size; i++) {
        for (int j = 0; j < obj->store[i].size; j++) {
            free(obj->store[i].values[j].key);
            free(obj->store[i].values[j].value);
        }
        free(obj->store[i].values);
        free(obj->store[i].key);
    }
    free(obj->store);
    free(obj);
}