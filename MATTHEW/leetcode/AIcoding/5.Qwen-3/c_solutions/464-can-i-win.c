#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* key;
    int value;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** table;
    int size;
} HashMap;

HashMap* createHashMap(int size) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    map->table = (HashNode**)calloc(size, sizeof(HashNode*));
    return map;
}

unsigned long hash(char* str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

void put(HashMap* map, char* key, int value) {
    unsigned long index = hash(key) % map->size;
    HashNode* node = (HashNode*)malloc(sizeof(HashNode));
    node->key = strdup(key);
    node->value = value;
    node->next = map->table[index];
    map->table[index] = node;
}

int get(HashMap* map, char* key) {
    unsigned long index = hash(key) % map->size;
    HashNode* node = map->table[index];
    while (node) {
        if (strcmp(node->key, key) == 0) {
            return node->value;
        }
        node = node->next;
    }
    return -1;
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->size; i++) {
        HashNode* node = map->table[i];
        while (node) {
            HashNode* temp = node;
            node = node->next;
            free(temp->key);
            free(temp);
        }
    }
    free(map->table);
    free(map);
}

int canIWinHelper(int maxChoosableInteger, int desiredTotal, int used, int currentSum, HashMap* memo) {
    char key[20];
    sprintf(key, "%d,%d", used, currentSum);
    int result = get(memo, key);
    if (result != -1) {
        return result;
    }

    for (int i = 1; i <= maxChoosableInteger; i++) {
        if (!(used & (1 << (i - 1)))) {
            if (currentSum + i >= desiredTotal) {
                put(memo, key, 1);
                return 1;
            }
            if (!canIWinHelper(maxChoosableInteger, desiredTotal, used | (1 << (i - 1)), currentSum + i, memo)) {
                put(memo, key, 1);
                return 1;
            }
        }
    }

    put(memo, key, 0);
    return 0;
}

int canIWin(int maxChoosableInteger, int desiredTotal) {
    if (desiredTotal <= 0) return 1;
    if (maxChoosableInteger >= desiredTotal) return 1;
    if ((maxChoosableInteger * (maxChoosableInteger + 1)) / 2 < desiredTotal) return 0;

    HashMap* memo = createHashMap(10000);
    int result = canIWinHelper(maxChoosableInteger, desiredTotal, 0, 0, memo);
    freeHashMap(memo);
    return result;
}