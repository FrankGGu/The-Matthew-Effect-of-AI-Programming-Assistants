#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 1000

struct HashNode {
    char* key;
    int index;
    struct HashNode* next;
};

struct HashMap {
    struct HashNode** table;
    int size;
};

struct HashMap* createHashMap(int size) {
    struct HashMap* map = (struct HashMap*)malloc(sizeof(struct HashMap));
    map->size = size;
    map->table = (struct HashNode**)malloc(sizeof(struct HashNode*) * size);
    for (int i = 0; i < size; i++) {
        map->table[i] = NULL;
    }
    return map;
}

unsigned long hash(char* key) {
    unsigned long hash = 5381;
    int c;
    while ((c = *key++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

void insert(struct HashMap* map, char* key, int index) {
    unsigned long h = hash(key) % map->size;
    struct HashNode* newNode = (struct HashNode*)malloc(sizeof(struct HashNode));
    newNode->key = key;
    newNode->index = index;
    newNode->next = map->table[h];
    map->table[h] = newNode;
}

int getIndex(struct HashMap* map, char* key) {
    unsigned long h = hash(key) % map->size;
    struct HashNode* node = map->table[h];
    while (node) {
        if (strcmp(node->key, key) == 0) {
            return node->index;
        }
        node = node->next;
    }
    return -1;
}

char** findRestaurant(char** list1, int list1Size, char** list2, int list2Size, int* returnSize) {
    struct HashMap* map = createHashMap(MAX_SIZE);
    int minIndexSum = INT_MAX;
    char** result = (char**)malloc(sizeof(char*) * MAX_SIZE);
    *returnSize = 0;

    for (int i = 0; i < list1Size; i++) {
        insert(map, list1[i], i);
    }

    for (int i = 0; i < list2Size; i++) {
        int index1 = getIndex(map, list2[i]);
        if (index1 != -1) {
            int indexSum = i + index1;
            if (indexSum < minIndexSum) {
                minIndexSum = indexSum;
                *returnSize = 0;
                result[*returnSize] = list2[i];
                (*returnSize)++;
            } else if (indexSum == minIndexSum) {
                result[*returnSize] = list2[i];
                (*returnSize)++;
            }
        }
    }

    return result;
}