#include <stdlib.h>

typedef struct Node {
    int key;
    int value;
    struct Node* next;
} Node;

typedef struct {
    int size;
    Node** table;
} HashTable;

HashTable* createHashTable(int size) {
    HashTable* ht = (HashTable*) malloc(sizeof(HashTable));
    ht->size = size;
    ht->table = (Node**) calloc(size, sizeof(Node*));
    return ht;
}

int hash(int key, int size) {
    return (key % size + size) % size;
}

void insert(HashTable* ht, int key, int value) {
    int index = hash(key, ht->size);
    Node* newNode = (Node*) malloc(sizeof(Node));
    newNode->key = key;
    newNode->value = value;
    newNode->next = ht->table[index];
    ht->table[index] = newNode;
}

int search(HashTable* ht, int key) {
    int index = hash(key, ht->size);
    Node* current = ht->table[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->value;
        }
        current = current->next;
    }
    return -1;
}

void freeHashTable(HashTable* ht) {
    for (int i = 0; i < ht->size; i++) {
        Node* current = ht->table[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(ht->table);
    free(ht);
}

int* twoSum(int* nums, int numsSize, int target, int* returnSize) {
    int HASH_TABLE_SIZE = 20003; 
    HashTable* ht = createHashTable(HASH_TABLE_SIZE);

    *returnSize = 2;
    int* result = (int*) malloc(2 * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        int complement = target - nums[i];
        int complement_idx = search(ht, complement);

        if (complement_idx != -1) {
            result[0] = complement_idx;
            result[1] = i;
            freeHashTable(ht);
            return result;
        }
        insert(ht, nums[i], i);
    }

    freeHashTable(ht);
    return NULL;
}