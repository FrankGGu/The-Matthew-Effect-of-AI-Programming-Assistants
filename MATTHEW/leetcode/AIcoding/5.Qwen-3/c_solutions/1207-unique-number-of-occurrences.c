#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int key;
    int value;
} HashNode;

typedef struct {
    HashNode *nodes;
    int size;
} HashSet;

HashSet* createHashSet(int capacity) {
    HashSet *set = (HashSet*)malloc(sizeof(HashSet));
    set->nodes = (HashNode*)calloc(capacity, sizeof(HashNode));
    set->size = 0;
    return set;
}

int hash(int key, int capacity) {
    return abs(key) % capacity;
}

void insert(HashSet *set, int key) {
    int index = hash(key, set->size);
    while (set->nodes[index].key != 0) {
        index = (index + 1) % set->size;
    }
    set->nodes[index].key = key;
    set->nodes[index].value = 1;
}

int contains(HashSet *set, int key) {
    int index = hash(key, set->size);
    while (set->nodes[index].key != 0) {
        if (set->nodes[index].key == key) {
            return 1;
        }
        index = (index + 1) % set->size;
    }
    return 0;
}

int uniqueOccurrences(int* arr, int arrSize) {
    int freq[101] = {0};
    for (int i = 0; i < arrSize; i++) {
        freq[arr[i] + 50]++;
    }

    HashSet *set = createHashSet(101);
    for (int i = 0; i < 101; i++) {
        if (freq[i] > 0) {
            if (contains(set, freq[i])) {
                return 0;
            }
            insert(set, freq[i]);
        }
    }
    return 1;
}