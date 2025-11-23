#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode **stack;
    int top;
    int capacity;
} BSTIterator;

BSTIterator* bSTIteratorCreate(struct TreeNode* root) {
    BSTIterator* iterator = (BSTIterator*)malloc(sizeof(BSTIterator));
    iterator->capacity = 10000;
    iterator->stack = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * iterator->capacity);
    iterator->top = -1;

    while (root != NULL) {
        iterator->stack[++iterator->top] = root;
        root = root->left;
    }

    return iterator;
}

int bSTIteratorNext(BSTIterator* iterator) {
    struct TreeNode* node = iterator->stack[iterator->top--];
    int val = node->val;
    struct TreeNode* current = node->right;

    while (current != NULL) {
        iterator->stack[++iterator->top] = current;
        current = current->left;
    }

    return val;
}

bool bSTIteratorHasNext(BSTIterator* iterator) {
    return iterator->top != -1;
}

void bSTIteratorFree(BSTIterator* iterator) {
    free(iterator->stack);
    free(iterator);
}