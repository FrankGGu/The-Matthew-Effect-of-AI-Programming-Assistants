#include <stdlib.h>
#include <limits.h>

#define HASH_TABLE_SIZE 200003

typedef struct HashNode {
    long long key;
    int value;
    struct HashNode *next;
} HashNode;

HashNode *hashTable[HASH_TABLE_SIZE];

int hash(long long key) {
    return (int)(key % HASH_TABLE_SIZE);
}

void insert(long long key, int value) {
    int index = hash(key);
    HashNode *node = hashTable[index];
    while (node != NULL) {
        if (node->key == key) {
            node->value = value;
            return;
        }
        node = node->next;
    }
    HashNode *newNode = (HashNode *)malloc(sizeof(HashNode));
    newNode->key = key;
    newNode->value = value;
    newNode->next = hashTable[index];
    hashTable[index] = newNode;
}

int get(long long key) {
    int index = hash(key);
    HashNode *node = hashTable[index];
    while (node != NULL) {
        if (node->key == key) {
            return node->value;
        }
        node = node->next;
    }
    return -2;
}

void clearHashTable() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        HashNode *node = hashTable[i];
        while (node != NULL) {
            HashNode *temp = node;
            node = node->next;
            free(temp);
        }
        hashTable[i] = NULL;
    }
}

int min(int a, int b) {
    return a < b ? a : b;
}

int minOperations(int* nums, int numsSize, int k) {
    clearHashTable();

    long long initial_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        initial_sum += nums[i];
    }

    long long target_rem = initial_sum % k;

    if (target_rem == 0) {
        return 0;
    }

    int min_len = numsSize + 1;

    insert(0, -1);

    long long current_prefix_sum_rem = 0;

    for (int i = 0; i < numsSize; i++) {
        current_prefix_sum_rem = (current_prefix_sum_rem + nums[i]) % k;

        long long needed_rem = (current_prefix_sum_rem - target_rem + k) % k;

        int found_idx = get(needed_rem);
        if (found_idx != -2) {
            min_len = min(min_len, i - found_idx);
        }

        insert(current_prefix_sum_rem, i);
    }

    return min_len;
}