#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int value;
} HashNode;

typedef struct {
    HashNode **table;
    int size;
} HashSet;

HashSet *createHashSet(int capacity) {
    HashSet *set = (HashSet *)malloc(sizeof(HashSet));
    set->size = 0;
    set->table = (HashNode **)calloc(capacity, sizeof(HashNode *));
    return set;
}

unsigned long hash(char *s) {
    unsigned long hash = 0;
    for (int i = 0; s[i]; i++) {
        hash = (hash * 131) + s[i];
    }
    return hash;
}

void addHash(HashSet *set, char *s) {
    unsigned long h = hash(s);
    int index = h % set->size;
    while (set->table[index] != NULL) {
        if (strcmp(set->table[index]->key, s) == 0) {
            return;
        }
        index = (index + 1) % set->size;
    }
    HashNode *node = (HashNode *)malloc(sizeof(HashNode));
    node->key = strdup(s);
    node->value = 1;
    set->table[index] = node;
}

int containsHash(HashSet *set, char *s) {
    unsigned long h = hash(s);
    int index = h % set->size;
    while (set->table[index] != NULL) {
        if (strcmp(set->table[index]->key, s) == 0) {
            return 1;
        }
        index = (index + 1) % set->size;
    }
    return 0;
}

void freeHashSet(HashSet *set) {
    for (int i = 0; i < set->size; i++) {
        if (set->table[i] != NULL) {
            free(set->table[i]->key);
            free(set->table[i]);
        }
    }
    free(set->table);
    free(set);
}

bool hasAllCodes(char *s, int k) {
    int len = strlen(s);
    if (k == 0 || len < k) return false;
    int capacity = 1 << k;
    HashSet *set = createHashSet(capacity);
    for (int i = 0; i <= len - k; i++) {
        char *sub = (char *)malloc(k + 1);
        strncpy(sub, s + i, k);
        sub[k] = '\0';
        addHash(set, sub);
        free(sub);
    }
    for (int i = 0; i < (1 << k); i++) {
        char *binary = (char *)malloc(k + 1);
        for (int j = 0; j < k; j++) {
            binary[j] = (i >> (k - 1 - j)) & 1 ? '1' : '0';
        }
        binary[k] = '\0';
        if (!containsHash(set, binary)) {
            free(binary);
            freeHashSet(set);
            return false;
        }
        free(binary);
    }
    freeHashSet(set);
    return true;
}