#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int key;
    int value;
} HashNode;

typedef struct {
    HashNode *nodes;
    int size;
} HashMap;

HashMap* createHashMap(int capacity) {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->size = 0;
    map->nodes = (HashNode*)calloc(capacity, sizeof(HashNode));
    return map;
}

void freeHashMap(HashMap *map) {
    free(map->nodes);
    free(map);
}

int hash(int key, int capacity) {
    return abs(key) % capacity;
}

void put(HashMap *map, int key) {
    int index = hash(key, map->size);
    while (map->nodes[index].key != 0) {
        if (map->nodes[index].key == key) {
            map->nodes[index].value++;
            return;
        }
        index = (index + 1) % map->size;
    }
    map->nodes[index].key = key;
    map->nodes[index].value = 1;
}

int get(HashMap *map, int key) {
    int index = hash(key, map->size);
    while (map->nodes[index].key != 0) {
        if (map->nodes[index].key == key) {
            return map->nodes[index].value;
        }
        index = (index + 1) % map->size;
    }
    return 0;
}

int leastBricks(int** wall, int wallSize, int* wallColSize) {
    HashMap *map = createHashMap(10000);
    for (int i = 0; i < wallSize; i++) {
        int current = 0;
        for (int j = 0; j < wallColSize[i] - 1; j++) {
            current += wall[i][j];
            put(map, current);
        }
    }
    int max = 0;
    for (int i = 0; i < map->size; i++) {
        if (map->nodes[i].key != 0 && map->nodes[i].value > max) {
            max = map->nodes[i].value;
        }
    }
    freeHashMap(map);
    return wallSize - max;
}