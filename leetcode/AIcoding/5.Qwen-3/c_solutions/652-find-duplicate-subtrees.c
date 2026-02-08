#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    char *key;
    struct TreeNode *node;
    struct TreeNode *next;
} HashNode;

typedef struct {
    HashNode **table;
    int size;
} HashTable;

HashTable *createHashTable(int size) {
    HashTable *ht = (HashTable *)malloc(sizeof(HashTable));
    ht->size = size;
    ht->table = (HashNode **)calloc(size, sizeof(HashNode *));
    return ht;
}

unsigned long hash(char *str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++))
        hash = ((hash << 5) + hash) + c;
    return hash;
}

char *serialize(TreeNode *root) {
    if (!root) return strdup("null");
    char *left = serialize(root->left);
    char *right = serialize(root->right);
    char *s = (char *)malloc(strlen(left) + strlen(right) + 10);
    sprintf(s, "%d,%s,%s", root->val, left, right);
    free(left);
    free(right);
    return s;
}

TreeNode **findDuplicateSubtrees(struct TreeNode *root, int *returnSize) {
    *returnSize = 0;
    TreeNode **result = (TreeNode **)malloc(0);
    HashTable *ht = createHashTable(1000);

    void dfs(struct TreeNode *node) {
        if (!node) return;
        char *s = serialize(node);
        unsigned long h = hash(s) % ht->size;
        HashNode *current = ht->table[h];
        while (current) {
            if (strcmp(current->key, s) == 0) {
                if (current->node != node) {
                    result = (TreeNode **)realloc(result, (*returnSize + 1) * sizeof(TreeNode *));
                    result[*returnSize] = current->node;
                    (*returnSize)++;
                }
                free(s);
                return;
            }
            current = current->next;
        }
        HashNode *newNode = (HashNode *)malloc(sizeof(HashNode));
        newNode->key = s;
        newNode->node = node;
        newNode->next = ht->table[h];
        ht->table[h] = newNode;
    }

    dfs(root);
    return result;
}