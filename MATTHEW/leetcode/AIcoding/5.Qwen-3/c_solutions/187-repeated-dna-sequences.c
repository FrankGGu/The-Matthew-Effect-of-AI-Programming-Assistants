#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* key;
    int count;
} HashNode;

typedef struct {
    HashNode* data;
    int size;
    int capacity;
} HashSet;

HashSet* createHashSet(int capacity) {
    HashSet* set = (HashSet*)malloc(sizeof(HashSet));
    set->data = (HashNode*)calloc(capacity, sizeof(HashNode));
    set->size = 0;
    set->capacity = capacity;
    return set;
}

unsigned long hash(char* str) {
    unsigned long hash = 0;
    while (*str) {
        hash = (hash << 5) + *str++;
    }
    return hash;
}

int contains(HashSet* set, char* key) {
    unsigned long h = hash(key);
    int index = h % set->capacity;
    for (int i = 0; i < set->size; i++) {
        int idx = (index + i) % set->capacity;
        if (set->data[idx].key && strcmp(set->data[idx].key, key) == 0) {
            return 1;
        }
    }
    return 0;
}

void add(HashSet* set, char* key) {
    unsigned long h = hash(key);
    int index = h % set->capacity;
    for (int i = 0; i < set->size; i++) {
        int idx = (index + i) % set->capacity;
        if (set->data[idx].key == NULL) {
            set->data[idx].key = strdup(key);
            set->data[idx].count = 1;
            set->size++;
            return;
        } else if (strcmp(set->data[idx].key, key) == 0) {
            set->data[idx].count++;
            return;
        }
    }
}

char** findRepeatedDnaSequences(char* s, int* returnSize) {
    if (strlen(s) < 10) {
        *returnSize = 0;
        return NULL;
    }

    HashSet* set = createHashSet(100000);
    char* sequence = (char*)malloc(11 * sizeof(char));
    char** result = (char**)malloc(1000 * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i <= strlen(s) - 10; i++) {
        strncpy(sequence, s + i, 10);
        sequence[10] = '\0';
        if (contains(set, sequence)) {
            add(set, sequence);
        } else {
            add(set, sequence);
        }
    }

    for (int i = 0; i < set->size; i++) {
        if (set->data[i].count > 1) {
            result[*returnSize] = strdup(set->data[i].key);
            (*returnSize)++;
        }
    }

    free(sequence);
    free(set->data);
    free(set);
    return result;
}