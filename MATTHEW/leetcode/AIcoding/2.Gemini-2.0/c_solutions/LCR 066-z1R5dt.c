#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* key;
    int val;
} Pair;

typedef struct {
    Pair* pairs;
    int size;
    int capacity;
} MapSum;

MapSum* mapSumCreate() {
    MapSum* obj = (MapSum*)malloc(sizeof(MapSum));
    obj->pairs = (Pair*)malloc(sizeof(Pair) * 1000);
    obj->size = 0;
    obj->capacity = 1000;
    return obj;
}

void mapSumInsert(MapSum* obj, char *key, int val) {
    for (int i = 0; i < obj->size; i++) {
        if (strcmp(obj->pairs[i].key, key) == 0) {
            obj->pairs[i].val = val;
            return;
        }
    }

    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->pairs = (Pair*)realloc(obj->pairs, sizeof(Pair) * obj->capacity);
    }

    obj->pairs[obj->size].key = (char*)malloc(strlen(key) + 1);
    strcpy(obj->pairs[obj->size].key, key);
    obj->pairs[obj->size].val = val;
    obj->size++;
}

int mapSumSum(MapSum* obj, char *prefix) {
    int sum = 0;
    for (int i = 0; i < obj->size; i++) {
        if (strncmp(obj->pairs[i].key, prefix, strlen(prefix)) == 0) {
            sum += obj->pairs[i].val;
        }
    }
    return sum;
}

void mapSumFree(MapSum* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->pairs[i].key);
    }
    free(obj->pairs);
    free(obj);
}