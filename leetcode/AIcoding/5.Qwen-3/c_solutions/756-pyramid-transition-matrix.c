#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int count;
    struct HashNode *next;
} HashNode;

typedef struct {
    HashNode **table;
    int size;
} HashMap;

HashMap *createHashMap(int size) {
    HashMap *map = (HashMap *)malloc(sizeof(HashMap));
    map->size = size;
    map->table = (HashNode **)calloc(size, sizeof(HashNode *));
    return map;
}

unsigned long hash(char *str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++))
        hash = ((hash << 5) + hash) + c;
    return hash;
}

void insertHash(HashMap *map, char *key) {
    unsigned long index = hash(key) % map->size;
    HashNode *node = map->table[index];
    while (node) {
        if (strcmp(node->key, key) == 0) {
            node->count++;
            return;
        }
        node = node->next;
    }
    node = (HashNode *)malloc(sizeof(HashNode));
    node->key = strdup(key);
    node->count = 1;
    node->next = map->table[index];
    map->table[index] = node;
}

int getHashCount(HashMap *map, char *key) {
    unsigned long index = hash(key) % map->size;
    HashNode *node = map->table[index];
    while (node) {
        if (strcmp(node->key, key) == 0)
            return node->count;
        node = node->next;
    }
    return 0;
}

void freeHashMap(HashMap *map) {
    for (int i = 0; i < map->size; i++) {
        HashNode *node = map->table[i];
        while (node) {
            HashNode *next = node->next;
            free(node->key);
            free(node);
            node = next;
        }
    }
    free(map->table);
    free(map);
}

char **getCombinations(char **bricks, int bricksSize, int *returnSize) {
    *returnSize = 0;
    char **result = NULL;
    if (bricksSize == 0)
        return result;
    if (bricksSize == 1) {
        result = (char **)malloc(sizeof(char *));
        result[0] = strdup(bricks[0]);
        *returnSize = 1;
        return result;
    }

    int len = strlen(bricks[0]);
    char **prev = getCombinations(bricks + 1, bricksSize - 1, returnSize);
    if (*returnSize == 0)
        return result;

    int total = 0;
    for (int i = 0; i < *returnSize; i++) {
        char *prefix = prev[i];
        for (int j = 0; j < len; j++) {
            char *newStr = (char *)malloc(len + 1);
            strncpy(newStr, prefix, len);
            newStr[len] = '\0';
            newStr[0] = bricks[0][j];
            for (int k = 1; k < len; k++) {
                newStr[k] = bricks[k][j];
            }
            total++;
        }
    }

    result = (char **)malloc(total * sizeof(char *));
    int idx = 0;
    for (int i = 0; i < *returnSize; i++) {
        char *prefix = prev[i];
        for (int j = 0; j < len; j++) {
            char *newStr = (char *)malloc(len + 1);
            strncpy(newStr, prefix, len);
            newStr[len] = '\0';
            newStr[0] = bricks[0][j];
            for (int k = 1; k < len; k++) {
                newStr[k] = bricks[k][j];
            }
            result[idx++] = newStr;
        }
    }

    *returnSize = total;
    return result;
}

bool canGenerate(char **bottom, int bottomSize, HashMap *map) {
    if (bottomSize == 1)
        return true;
    char *key = (char *)malloc(bottomSize * sizeof(char));
    strncpy(key, bottom[0], bottomSize);
    key[bottomSize] = '\0';
    int count = getHashCount(map, key);
    if (count == 0)
        return false;
    char **combinations = NULL;
    int combinationsSize = 0;
    combinations = getCombinations(bottom, bottomSize, &combinationsSize);
    for (int i = 0; i < combinationsSize; i++) {
        if (canGenerate(combinations[i], bottomSize - 1, map)) {
            free(combinations[i]);
            free(key);
            return true;
        }
    }
    for (int i = 0; i < combinationsSize; i++)
        free(combinations[i]);
    free(combinations);
    free(key);
    return false;
}

bool pyramidTransition(char *bottom, char **allowed, int allowedSize) {
    int len = strlen(bottom);
    HashMap *map = createHashMap(1000);
    for (int i = 0; i < allowedSize; i++) {
        char *key = (char *)malloc(3);
        strncpy(key, allowed[i], 2);
        key[2] = '\0';
        insertHash(map, key);
    }
    bool result = canGenerate(bottom, len, map);
    freeHashMap(map);
    return result;
}