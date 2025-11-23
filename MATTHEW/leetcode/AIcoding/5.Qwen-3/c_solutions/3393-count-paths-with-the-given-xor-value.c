#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int val;
    int count;
} HashNode;

typedef struct {
    HashNode *table;
    int size;
} HashMap;

HashMap* createHashMap(int capacity) {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->size = 0;
    map->table = (HashNode*)calloc(capacity, sizeof(HashNode));
    return map;
}

void freeHashMap(HashMap *map) {
    free(map->table);
    free(map);
}

int getHash(int key, int capacity) {
    return abs(key) % capacity;
}

void insert(HashMap *map, int key) {
    int index = getHash(key, map->size);
    while (map->table[index].val != 0) {
        if (map->table[index].val == key) {
            map->table[index].count++;
            return;
        }
        index = (index + 1) % map->size;
    }
    map->table[index].val = key;
    map->table[index].count = 1;
}

int get(HashMap *map, int key) {
    int index = getHash(key, map->size);
    while (map->table[index].val != 0) {
        if (map->table[index].val == key) {
            return map->table[index].count;
        }
        index = (index + 1) % map->size;
    }
    return 0;
}

int countPaths(int** grid, int gridSize, int* gridColSize, int target) {
    int rows = gridSize;
    int cols = gridColSize[0];
    HashMap *map = createHashMap(rows * cols);
    int currentXOR = 0;
    insert(map, 0);
    int result = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            currentXOR ^= grid[i][j];
            result += get(map, currentXOR ^ target);
            insert(map, currentXOR);
        }
    }

    freeHashMap(map);
    return result;
}