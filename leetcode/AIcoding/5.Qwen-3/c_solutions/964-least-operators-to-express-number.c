#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int leastOpsEqn(int x, int y); 

typedef struct {
    int key;
    int value;
} Pair;

typedef struct {
    Pair* data;
    int size;
    int capacity;
} HashMap;

HashMap* createHashMap() {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->size = 0;
    map->capacity = 16;
    map->data = (Pair*)calloc(map->capacity, sizeof(Pair));
    return map;
}

void put(HashMap* map, int key, int value) {
    for (int i = 0; i < map->size; i++) {
        if (map->data[i].key == key) {
            map->data[i].value = value;
            return;
        }
    }
    if (map->size >= map->capacity) {
        map->capacity *= 2;
        map->data = (Pair*)realloc(map->data, map->capacity * sizeof(Pair));
    }
    map->data[map->size++].key = key;
    map->data[map->size - 1].value = value;
}

int get(HashMap* map, int key) {
    for (int i = 0; i < map->size; i++) {
        if (map->data[i].key == key) {
            return map->data[i].value;
        }
    }
    return INT_MAX;
}

void freeHashMap(HashMap* map) {
    free(map->data);
    free(map);
}

int dfs(int x, int y, HashMap* memo) {
    if (y == 0) return 0;
    if (y == 1) return 1;
    if (get(memo, y) != INT_MAX) return get(memo, y);

    int res = INT_MAX;
    int k = 0;
    int curr = 1;
    while (curr < y) {
        curr *= x;
        k++;
    }

    if (curr == y) {
        res = k;
    } else {
        int a = dfs(x, y - curr / x, memo) + k - 1;
        int b = dfs(x, curr - y, memo) + k;
        res = fmin(a, b);
    }

    put(memo, y, res);
    return res;
}

int leastOpsEqn(int x, int y) {
    if (x == 1) return y - 1;
    HashMap* memo = createHashMap();
    int result = dfs(x, y, memo);
    freeHashMap(memo);
    return result;
}