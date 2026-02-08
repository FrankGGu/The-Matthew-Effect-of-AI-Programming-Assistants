#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct HashNode {
    int key;
    int count;
    struct HashNode *next;
} HashNode;

typedef struct {
    HashNode **table;
    int size;
} HashMap;

HashMap* createHashMap(int size) {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    map->table = (HashNode**)calloc(size, sizeof(HashNode*));
    return map;
}

unsigned int hashFunction(int key, int size) {
    return (unsigned int)(key % size);
}

void insertIntoHashMap(HashMap *map, int key) {
    unsigned int index = hashFunction(key, map->size);
    HashNode *current = map->table[index];
    while (current) {
        if (current->key == key) {
            current->count++;
            return;
        }
        current = current->next;
    }
    HashNode *newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->key = key;
    newNode->count = 1;
    newNode->next = map->table[index];
    map->table[index] = newNode;
}

int* findFrequentTreeSum(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    HashMap *map = createHashMap(1000);
    int maxCount = 0;
    int sumCount = 0;

    int* result = NULL;

    int postOrder(struct TreeNode* node) {
        if (!node) return 0;
        int left = postOrder(node->left);
        int right = postOrder(node->right);
        int sum = left + right + node->val;
        insertIntoHashMap(map, sum);
        return sum;
    }

    postOrder(root);

    for (int i = 0; i < map->size; i++) {
        HashNode *current = map->table[i];
        while (current) {
            if (current->count > maxCount) {
                maxCount = current->count;
                sumCount = 1;
            } else if (current->count == maxCount) {
                sumCount++;
            }
            current = current->next;
        }
    }

    result = (int*)malloc(sumCount * sizeof(int));
    int index = 0;

    for (int i = 0; i < map->size; i++) {
        HashNode *current = map->table[i];
        while (current) {
            if (current->count == maxCount) {
                result[index++] = current->key;
            }
            current = current->next;
        }
    }

    *returnSize = sumCount;
    return result;
}