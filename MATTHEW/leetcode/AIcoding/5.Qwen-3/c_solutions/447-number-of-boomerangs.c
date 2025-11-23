#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int key;
    int count;
} HashNode;

typedef struct {
    HashNode *data;
    int size;
} HashMap;

HashMap* createHashMap(int capacity) {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->size = 0;
    map->data = (HashNode*)calloc(capacity, sizeof(HashNode));
    return map;
}

void freeHashMap(HashMap *map) {
    free(map->data);
    free(map);
}

int getHashCode(int x, int y) {
    return x * 100000 + y;
}

void put(HashMap *map, int x, int y) {
    int hash = getHashCode(x, y);
    for (int i = 0; i < map->size; i++) {
        if (map->data[i].key == hash) {
            map->data[i].count++;
            return;
        }
    }
    if (map->size >= 1000) return;
    map->data[map->size].key = hash;
    map->data[map->size++].count = 1;
}

int get(HashMap *map, int x, int y) {
    int hash = getHashCode(x, y);
    for (int i = 0; i < map->size; i++) {
        if (map->data[i].key == hash) {
            return map->data[i].count;
        }
    }
    return 0;
}

int numberOfBoomerangs(int** points, int pointsSize, int* pointsColSize) {
    int result = 0;
    for (int i = 0; i < pointsSize; i++) {
        HashMap *map = createHashMap(1000);
        for (int j = 0; j < pointsSize; j++) {
            if (i == j) continue;
            int dx = points[i][0] - points[j][0];
            int dy = points[i][1] - points[j][1];
            put(map, dx, dy);
        }
        for (int k = 0; k < map->size; k++) {
            int count = map->data[k].count;
            result += count * (count - 1);
        }
        freeHashMap(map);
    }
    return result;
}