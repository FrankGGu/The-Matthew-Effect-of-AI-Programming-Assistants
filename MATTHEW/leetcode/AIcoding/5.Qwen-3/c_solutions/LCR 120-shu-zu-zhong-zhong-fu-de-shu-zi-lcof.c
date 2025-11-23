#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int value;
} Pair;

typedef struct {
    Pair *data;
    int size;
    int capacity;
} HashMap;

HashMap *createHashMap() {
    HashMap *map = (HashMap *)malloc(sizeof(HashMap));
    map->size = 0;
    map->capacity = 16;
    map->data = (Pair *)calloc(map->capacity, sizeof(Pair));
    return map;
}

unsigned long hash(char *str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

void put(HashMap *map, char *key, int value) {
    unsigned long h = hash(key);
    int index = h % map->capacity;
    while (map->data[index].key != NULL) {
        if (strcmp(map->data[index].key, key) == 0) {
            map->data[index].value = value;
            return;
        }
        index = (index + 1) % map->capacity;
    }
    map->data[index].key = strdup(key);
    map->data[index].value = value;
    map->size++;
}

int get(HashMap *map, char *key) {
    unsigned long h = hash(key);
    int index = h % map->capacity;
    while (map->data[index].key != NULL) {
        if (strcmp(map->data[index].key, key) == 0) {
            return map->data[index].value;
        }
        index = (index + 1) % map->capacity;
    }
    return -1;
}

void freeHashMap(HashMap *map) {
    for (int i = 0; i < map->capacity; i++) {
        free(map->data[i].key);
    }
    free(map->data);
    free(map);
}

int findDuplicate(char **paths, int pathsSize) {
    HashMap *map = createHashMap();
    for (int i = 0; i < pathsSize; i++) {
        char *path = paths[i];
        char *token = strtok(path, " ");
        while (token != NULL) {
            char *file = strchr(token, '(');
            if (file != NULL) {
                char *content = strchr(file, ')');
                if (content != NULL) {
                    *content = '\0';
                    content++;
                    int value = atoi(content);
                    char *key = strdup(file + 1);
                    int existingValue = get(map, key);
                    if (existingValue != -1) {
                        freeHashMap(map);
                        return value;
                    } else {
                        put(map, key, value);
                    }
                    free(key);
                }
            }
            token = strtok(NULL, " ");
        }
    }
    freeHashMap(map);
    return -1;
}