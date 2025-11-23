#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For calloc
#include <stdio.h>  // For NULL, not strictly necessary for LeetCode but good practice

typedef struct Node {
    int val;
    struct Node* next;
} Node;

typedef struct {
    Node** buckets;
    int capacity;
    int size; // Number of unique elements currently in the set
} HashSet;

unsigned int hash(int key, int capacity) {
    // A simple modulo hash function. Since keys are positive, this is fine.
    return (unsigned int)key % capacity;
}

HashSet* hashSetCreate(int capacity) {
    HashSet* set = (HashSet*)malloc(sizeof(HashSet));
    if (!set) return NULL;
    set->capacity = capacity;
    // calloc initializes memory to zero, so all bucket pointers are NULL
    set->buckets = (Node**)calloc(capacity, sizeof(Node*));
    if (!set->buckets) {
        free(set);
        return NULL;
    }
    set->size = 0;
    return set;
}

void hashSetAdd(HashSet* set, int val) {
    if (!set) return;

    unsigned int index = hash(val, set->capacity);
    Node* current = set->buckets[index];

    // Check if the value already exists in the chain
    while (current != NULL) {
        if (current->val == val) {
            return; // Already exists, no need to add
        }
        current = current->next;
    }

    // Value not found, add a new node to the beginning of the chain
    Node* newNode = (Node*)malloc(sizeof(Node));
    if (!newNode) return; // Handle allocation failure
    newNode->val = val;
    newNode->next = set->buckets[index];
    set->buckets[index] = newNode;
    set->size++;
}

void hashSetRemove(HashSet* set, int val) {
    if (!set) return;

    unsigned int index = hash(val, set->capacity);
    Node* current = set->buckets[index];
    Node* prev = NULL;

    // Traverse the chain to find the node to remove
    while (current != NULL) {
        if (current->val == val) {
            if (prev == NULL) {
                // Node to remove is the head of the chain
                set->buckets[index] = current->next;
            } else {
                // Node to remove is in the middle or end of the chain
                prev->next = current->next;
            }
            free(current); // Free the removed node
            set->size--;
            return; // Element removed
        }
        prev = current;
        current = current->next;
    }
}

bool hashSetContains(HashSet* set, int val) {
    if (!set) return false;

    unsigned int index = hash(val, set->capacity);
    Node* current = set->buckets[index];

    // Traverse the chain
    while (current != NULL) {
        if (current->val == val) {
            return true; // Element found
        }
        current = current->next;
    }
    return false; // Element not found
}

void hashSetFree(HashSet* set) {
    if (!set) return;

    for (int i = 0; i < set->capacity; i++) {
        Node* current = set->buckets[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp); // Free each node in the chain
        }
    }
    free(set->buckets); // Free the array of bucket pointers
    free(set);          // Free the HashSet structure itself
}

int compareInt(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int* relocateMarbles(int* nums, int numsSize, int* moveFrom, int moveFromSize, int* moveTo, int moveToSize, int* returnSize) {
    // Choose an initial capacity for the hash set.
    // Max number of unique positions can be numsSize + moveToSize.
    // A prime number roughly 2-4 times this maximum is a good heuristic for hash table capacity.
    // Max elements ~ 2 * 10^5. So, capacity ~ 4 * 10^5.
    int initialCapacity = 400003; // A prime number
    HashSet* set = hashSetCreate(initialCapacity);
    if (!set) {
        *returnSize = 0;
        return NULL;
    }

    // Add initial marble positions to the hash set
    for (int i = 0; i < numsSize; i++) {
        hashSetAdd(set, nums[i]);
    }

    // Process all moves
    for (int i = 0; i < moveFromSize; i++) {
        // If a marble exists at moveFrom[i], remove it and add it to moveTo[i]
        // The problem implies "if there are multiple marbles, only one moves".
        // Since we track unique positions, checking for presence and then removing/adding
        // correctly models this: the position `moveFrom[i]` is no longer occupied,
        // and `moveTo[i]` becomes occupied.
        if (hashSetContains(set, moveFrom[i])) {
            hashSetRemove(set, moveFrom[i]);
            hashSetAdd(set, moveTo[i]);
        }
    }

    // Collect all present marbles into a dynamically allocated array
    int* result = (int*)malloc(set->size * sizeof(int));
    if (!result) {
        hashSetFree(set);
        *returnSize = 0;
        return NULL;
    }

    int k = 0;
    for (int i = 0; i < set->capacity; i++) {
        Node* current = set->buckets[i];
        while (current != NULL) {
            result[k++] = current->val;
            current = current->next;
        }
    }

    // Sort the result array as required by the problem
    qsort(result, set->size, sizeof(int), compareInt);

    *returnSize = set->size;

    // Free the hash set and its internal structures
    hashSetFree(set);

    return result;
}