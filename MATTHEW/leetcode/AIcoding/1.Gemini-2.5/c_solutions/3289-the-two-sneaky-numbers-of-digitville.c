#include <stdlib.h>

typedef struct HashNode {
    int key;
    int val;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** table;
    int size;
} HashTable;

int hash(int key, int tableSize) {
    return (key % tableSize + tableSize) % tableSize;
}

HashTable* createHashTable(int tableSize) {
    HashTable* ht = (HashTable*)malloc(sizeof(HashTable));
    ht->size = tableSize;
    ht->table = (HashNode**)calloc(tableSize, sizeof(HashNode*));
    return ht;
}

void insert(HashTable* ht, int key, int val) {
    int index = hash(key, ht->size);
    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->key = key;
    newNode->val = val;
    newNode->next = ht->table[index];
    ht->table[index] = newNode;
}

int find(HashTable* ht, int key) {
    int index = hash(key, ht->size);
    HashNode* current = ht->table[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->val;
        }
        current = current->next;
    }
    return -1;
}

void freeHashTable(HashTable* ht) {
    for (int i = 0; i < ht->size; i++) {
        HashNode* current = ht->table[i];
        while (current != NULL) {
            HashNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(ht->table);
    free(ht);
}

int* twoSum(int* nums, int numsSize, int target, int* returnSize) {
    int HASH_TABLE_SIZE = 200003; 

    HashTable* ht = createHashTable(HASH_TABLE_SIZE);

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    for (int i = 0; i < numsSize; i++) {
        int complement = target - nums[i];
        int complement_idx = find(ht, complement);

        if (complement_idx != -1) {
            result[0] = complement_idx;
            result[1] = i;
            freeHashTable(ht);
            return result;
        }
        insert(ht, nums[i], i);
    }

    freeHashTable(ht);
    *returnSize = 0;
    return NULL;
}