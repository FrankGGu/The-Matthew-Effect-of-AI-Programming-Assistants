#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* key;
    char** anagrams;
    int size;
} HashNode;

typedef struct {
    HashNode** table;
    int capacity;
    int count;
} HashMap;

unsigned long hash(char* str) {
    unsigned long hash = 0;
    while (*str) {
        hash = (hash * 31) + *str++;
    }
    return hash;
}

char* sortString(char* s) {
    int len = strlen(s);
    char* sorted = (char*)malloc((len + 1) * sizeof(char));
    strcpy(sorted, s);
    for (int i = 0; i < len - 1; i++) {
        for (int j = 0; j < len - i - 1; j++) {
            if (sorted[j] > sorted[j + 1]) {
                char temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }
    return sorted;
}

HashMap* createHashMap(int capacity) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->capacity = capacity;
    map->count = 0;
    map->table = (HashNode**)calloc(capacity, sizeof(HashNode*));
    return map;
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->capacity; i++) {
        if (map->table[i]) {
            free(map->table[i]->key);
            for (int j = 0; j < map->table[i]->size; j++) {
                free(map->table[i]->anagrams[j]);
            }
            free(map->table[i]->anagrams);
            free(map->table[i]);
        }
    }
    free(map->table);
    free(map);
}

void insertIntoHashMap(HashMap* map, char* word) {
    char* sorted = sortString(word);
    unsigned long hashVal = hash(sorted) % map->capacity;
    HashNode* node = map->table[hashVal];
    if (!node) {
        node = (HashNode*)malloc(sizeof(HashNode));
        node->key = sorted;
        node->anagrams = (char**)malloc(sizeof(char*));
        node->anagrams[0] = strdup(word);
        node->size = 1;
        map->table[hashVal] = node;
        map->count++;
    } else {
        int found = 0;
        for (int i = 0; i < node->size; i++) {
            if (strcmp(node->key, sorted) == 0) {
                node->anagrams = (char**)realloc(node->anagrams, (node->size + 1) * sizeof(char*));
                node->anagrams[node->size++] = strdup(word);
                found = 1;
                break;
            }
        }
        if (!found) {
            node->anagrams = (char**)realloc(node->anagrams, (node->size + 1) * sizeof(char*));
            node->anagrams[node->size++] = strdup(word);
        }
    }
    free(sorted);
}

char** groupAnagrams(char** strs, int strsSize, int* returnSize) {
    HashMap* map = createHashMap(strsSize);
    for (int i = 0; i < strsSize; i++) {
        insertIntoHashMap(map, strs[i]);
    }

    *returnSize = map->count;
    char** result = (char**)malloc(map->count * sizeof(char*));
    int index = 0;

    for (int i = 0; i < map->capacity; i++) {
        if (map->table[i]) {
            result[index++] = map->table[i]->anagrams[0];
        }
    }

    freeHashMap(map);
    return result;
}