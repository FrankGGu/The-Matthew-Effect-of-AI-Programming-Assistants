#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define HASH_TABLE_SIZE 100003

typedef struct HashNode {
    int val;
    struct HashNode* next;
} HashNode;

HashNode* hashTable[HASH_TABLE_SIZE];

unsigned int hash(int val) {
    return (unsigned int)(((long long)val % HASH_TABLE_SIZE + HASH_TABLE_SIZE) % HASH_TABLE_SIZE);
}

void hash_insert(int val) {
    unsigned int h = hash(val);
    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->val = val;
    newNode->next = hashTable[h];
    hashTable[h] = newNode;
}

bool hash_search(int val) {
    unsigned int h = hash(val);
    HashNode* current = hashTable[h];
    while (current != NULL) {
        if (current->val == val) {
            return true;
        }
        current = current->next;
    }
    return false;
}

void hash_remove(int val) {
    unsigned int h = hash(val);
    HashNode* current = hashTable[h];
    HashNode* prev = NULL;

    while (current != NULL) {
        if (current->val == val) {
            if (prev == NULL) {
                hashTable[h] = current->next;
            } else {
                prev->next = current->next;
            }
            free(current);
            return;
        }
        prev = current;
        current = current->next;
    }
}

void hash_clear() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        HashNode* current = hashTable[i];
        while (current != NULL) {
            HashNode* temp = current;
            current = current->next;
            free(temp);
        }
        hashTable[i] = NULL;
    }
}

bool containsNearbyDuplicate(int* nums, int numsSize, int k) {
    hash_clear();

    for (int i = 0; i < numsSize; i++) {
        if (hash_search(nums[i])) {
            return true;
        }

        hash_insert(nums[i]);

        if (i >= k) {
            hash_remove(nums[i - k]);
        }
    }

    return false;
}