#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct HashNode {
    int key;
    int value;
    struct HashNode *next;
};

struct HashTable {
    int capacity;
    struct HashNode **table;
};

struct HashTable* createHashTable(int capacity) {
    struct HashTable* hashTable = (struct HashTable*)malloc(sizeof(struct HashTable));
    hashTable->capacity = capacity;
    hashTable->table = (struct HashNode**)calloc(capacity, sizeof(struct HashNode*));
    return hashTable;
}

int hashFunction(int key, int capacity) {
    return abs(key) % capacity;
}

void insert(struct HashTable* hashTable, int key) {
    int index = hashFunction(key, hashTable->capacity);
    struct HashNode* current = hashTable->table[index];

    while (current != NULL) {
        if (current->key == key) {
            current->value++;
            return;
        }
        current = current->next;
    }

    struct HashNode* newNode = (struct HashNode*)malloc(sizeof(struct HashNode));
    newNode->key = key;
    newNode->value = 1;
    newNode->next = hashTable->table[index];
    hashTable->table[index] = newNode;
}

int treeSum(struct TreeNode* root, struct HashTable* hashTable) {
    if (root == NULL) {
        return 0;
    }

    int leftSum = treeSum(root->left, hashTable);
    int rightSum = treeSum(root->right, hashTable);
    int sum = root->val + leftSum + rightSum;

    insert(hashTable, sum);
    return sum;
}

int* findFrequentTreeSum(struct TreeNode* root, int* returnSize) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    struct HashTable* hashTable = createHashTable(1000);
    treeSum(root, hashTable);

    int maxFrequency = 0;
    int count = 0;

    for (int i = 0; i < hashTable->capacity; i++) {
        struct HashNode* current = hashTable->table[i];
        while (current != NULL) {
            if (current->value > maxFrequency) {
                maxFrequency = current->value;
                count = 1;
            } else if (current->value == maxFrequency) {
                count++;
            }
            current = current->next;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    int index = 0;

    for (int i = 0; i < hashTable->capacity; i++) {
        struct HashNode* current = hashTable->table[i];
        while (current != NULL) {
            if (current->value == maxFrequency) {
                result[index++] = current->key;
            }
            current = current->next;
        }
    }

    *returnSize = count;
    return result;
}