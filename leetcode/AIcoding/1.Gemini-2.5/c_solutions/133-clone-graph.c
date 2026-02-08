#include <stdlib.h> // For malloc, free

struct Node {
    int val;
    int numNeighbors;
    struct Node** neighbors;
};

typedef struct MapEntry {
    struct Node* original;
    struct Node* cloned;
    struct MapEntry* next;
} MapEntry;

#define HASH_TABLE_SIZE 10007

MapEntry* hashTable[HASH_TABLE_SIZE];

unsigned int hash(struct Node* node_ptr) {
    return ((unsigned long)node_ptr >> 3) % HASH_TABLE_SIZE;
}

struct Node* getFromMap(struct Node* original) {
    unsigned int idx = hash(original);
    MapEntry* entry = hashTable[idx];
    while (entry != NULL) {
        if (entry->original == original) {
            return entry->cloned;
        }
        entry = entry->next;
    }
    return NULL;
}

void putToMap(struct Node* original, struct Node* cloned) {
    unsigned int idx = hash(original);
    MapEntry* entry = (MapEntry*)malloc(sizeof(MapEntry));
    entry->original = original;
    entry->cloned = cloned;
    entry->next = hashTable[idx];
    hashTable[idx] = entry;
}

void clearMap() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        MapEntry* entry = hashTable[i];
        while (entry != NULL) {
            MapEntry* temp = entry;
            entry = entry->next;
            free(temp);
        }
        hashTable[i] = NULL;
    }
}

struct Node* dfs(struct Node* node) {
    if (node == NULL) {
        return NULL;
    }

    struct Node* cloned_node = getFromMap(node);
    if (cloned_node != NULL) {
        return cloned_node;
    }

    cloned_node = (struct Node*)malloc(sizeof(struct Node));
    cloned_node->val = node->val;
    cloned_node->numNeighbors = node->numNeighbors;

    putToMap(node, cloned_node);

    if (node->numNeighbors > 0) {
        cloned_node->neighbors = (struct Node**)malloc(sizeof(struct Node*) * node->numNeighbors);
        for (int i = 0; i < node->numNeighbors; ++i) {
            cloned_node->neighbors[i] = dfs(node->neighbors[i]);
        }
    } else {
        cloned_node->neighbors = NULL;
    }

    return cloned_node;
}

struct Node* cloneGraph(struct Node* node) {
    clearMap();

    struct Node* result = dfs(node);

    clearMap(); 

    return result;
}