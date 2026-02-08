#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    TreeNode **stack;
    int top;
    int capacity;
} BSTIterator;

BSTIterator* bSTIteratorCreate(struct TreeNode* root) {
    BSTIterator* obj = (BSTIterator*)malloc(sizeof(BSTIterator));
    obj->capacity = 100;
    obj->stack = (TreeNode**)malloc(obj->capacity * sizeof(TreeNode*));
    obj->top = -1;

    while (root) {
        obj->stack[++obj->top] = root;
        root = root->left;
    }
    return obj;
}

bool bSTIteratorHasNext(BSTIterator* obj) {
    return obj->top >= 0;
}

int bSTIteratorNext(BSTIterator* obj) {
    TreeNode* node = obj->stack[obj->top--];
    int val = node->val;
    node = node->right;
    while (node) {
        obj->stack[++obj->top] = node;
        node = node->left;
    }
    return val;
}

void bSTIteratorFree(BSTIterator* obj) {
    free(obj->stack);
    free(obj);
}