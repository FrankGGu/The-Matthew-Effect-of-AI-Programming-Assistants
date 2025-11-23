#include <stdlib.h>
#include <string.h>

struct HashNode {
    char* key;
    int count;
    struct HashNode* next;
};

struct HashMap {
    struct HashNode** table;
    int size;
};

unsigned long hash(char* str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

struct HashMap* createHashMap(int size) {
    struct HashMap* map = malloc(sizeof(struct HashMap));
    map->table = malloc(sizeof(struct HashNode*) * size);
    for (int i = 0; i < size; i++) {
        map->table[i] = NULL;
    }
    map->size = size;
    return map;
}

void insert(struct HashMap* map, char* key) {
    unsigned long index = hash(key) % map->size;
    struct HashNode* current = map->table[index];
    while (current) {
        if (strcmp(current->key, key) == 0) {
            current->count++;
            return;
        }
        current = current->next;
    }
    struct HashNode* newNode = malloc(sizeof(struct HashNode));
    newNode->key = strdup(key);
    newNode->count = 1;
    newNode->next = map->table[index];
    map->table[index] = newNode;
}

char** getAnagrams(struct HashMap* map, int* returnSize) {
    char** result = malloc(sizeof(char*) * 10000); // maximum size, adjust as needed
    *returnSize = 0;
    for (int i = 0; i < map->size; i++) {
        struct HashNode* current = map->table[i];
        while (current) {
            if (current->count > 1) {
                result[(*returnSize)++] = current->key;
            }
            current = current->next;
        }
    }
    return result;
}

char*** groupAnagrams(char** strs, int strsSize, int** returnColumnSizes, int* returnSize) {
    struct HashMap* map = createHashMap(1000);
    char** keys = malloc(sizeof(char*) * strsSize);
    for (int i = 0; i < strsSize; i++) {
        char* sortedStr = strdup(strs[i]);
        qsort(sortedStr, strlen(sortedStr), sizeof(char), (int (*)(const void*, const void*))strcmp);
        insert(map, sortedStr);
        keys[i] = sortedStr;
    }

    char*** result = malloc(sizeof(char**) * 1000);
    *returnColumnSizes = malloc(sizeof(int) * 1000);
    *returnSize = 0;

    for (int i = 0; i < map->size; i++) {
        struct HashNode* current = map->table[i];
        if (current) {
            result[*returnSize] = malloc(sizeof(char*) * current->count);
            (*returnColumnSizes)[*returnSize] = current->count;
            int index = 0;
            while (current) {
                result[*returnSize][index++] = current->key;
                current = current->next;
            }
            (*returnSize)++;
        }
    }

    return result;
}