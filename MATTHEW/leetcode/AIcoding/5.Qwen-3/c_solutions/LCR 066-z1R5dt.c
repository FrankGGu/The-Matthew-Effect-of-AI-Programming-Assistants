#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int value;
} Pair;

typedef struct {
    Pair *pairs;
    int size;
} Map;

typedef struct {
    Map **buckets;
    int bucketSize;
} HashTable;

HashTable* createHashTable(int bucketSize) {
    HashTable *table = (HashTable*)malloc(sizeof(HashTable));
    table->bucketSize = bucketSize;
    table->buckets = (Map**)malloc(bucketSize * sizeof(Map*));
    for (int i = 0; i < bucketSize; i++) {
        table->buckets[i] = NULL;
    }
    return table;
}

unsigned long hash(char *str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

void put(HashTable *table, char *key, int value) {
    unsigned long index = hash(key) % table->bucketSize;
    if (table->buckets[index] == NULL) {
        table->buckets[index] = (Map*)malloc(sizeof(Map));
        table->buckets[index]->size = 0;
        table->buckets[index]->pairs = NULL;
    }
    Map *map = table->buckets[index];
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->pairs[i].key, key) == 0) {
            map->pairs[i].value = value;
            return;
        }
    }
    map->size++;
    map->pairs = (Pair*)realloc(map->pairs, map->size * sizeof(Pair));
    map->pairs[map->size - 1].key = strdup(key);
    map->pairs[map->size - 1].value = value;
}

int get(HashTable *table, char *key) {
    unsigned long index = hash(key) % table->bucketSize;
    if (table->buckets[index] == NULL) {
        return 0;
    }
    Map *map = table->buckets[index];
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->pairs[i].key, key) == 0) {
            return map->pairs[i].value;
        }
    }
    return 0;
}

void removeKey(HashTable *table, char *key) {
    unsigned long index = hash(key) % table->bucketSize;
    if (table->buckets[index] == NULL) {
        return;
    }
    Map *map = table->buckets[index];
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->pairs[i].key, key) == 0) {
            free(map->pairs[i].key);
            for (int j = i; j < map->size - 1; j++) {
                map->pairs[j] = map->pairs[j + 1];
            }
            map->size--;
            map->pairs = (Pair*)realloc(map->pairs, map->size * sizeof(Pair));
            if (map->size == 0) {
                free(map->pairs);
                free(map);
                table->buckets[index] = NULL;
            }
            return;
        }
    }
}

void destroyHashTable(HashTable *table) {
    for (int i = 0; i < table->bucketSize; i++) {
        if (table->buckets[i] != NULL) {
            for (int j = 0; j < table->buckets[i]->size; j++) {
                free(table->buckets[i]->pairs[j].key);
            }
            free(table->buckets[i]->pairs);
            free(table->buckets[i]);
        }
    }
    free(table->buckets);
    free(table);
}

typedef struct {
    HashTable *table;
} MapSum;

MapSum* mapSumCreate() {
    MapSum *obj = (MapSum*)malloc(sizeof(MapSum));
    obj->table = createHashTable(1000);
    return obj;
}

void mapSumInsert(MapSum* obj, char *key, int val) {
    put(obj->table, key, val);
}

int mapSumSum(MapSum* obj, char *prefix) {
    int total = 0;
    for (int i = 0; i < obj->table->bucketSize; i++) {
        if (obj->table->buckets[i] != NULL) {
            Map *map = obj->table->buckets[i];
            for (int j = 0; j < map->size; j++) {
                if (strncmp(map->pairs[j].key, prefix, strlen(prefix)) == 0) {
                    total += map->pairs[j].value;
                }
            }
        }
    }
    return total;
}

void mapSumFree(MapSum* obj) {
    destroyHashTable(obj->table);
    free(obj);
}