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

void pushLeft(TreeNode *root, BSTIterator *iter) {
    while (root) {
        if (iter->top == iter->capacity) {
            iter->capacity *= 2;
            iter->stack = (TreeNode **)realloc(iter->stack, iter->capacity * sizeof(TreeNode *));
        }
        iter->stack[iter->top++] = root;
        root = root->left;
    }
}

BSTIterator *bstIteratorCreate(TreeNode *root) {
    BSTIterator *iter = (BSTIterator *)malloc(sizeof(BSTIterator));
    iter->capacity = 1;
    iter->stack = (TreeNode **)malloc(sizeof(TreeNode *));
    iter->top = 0;
    pushLeft(root, iter);
    return iter;
}

int bstIteratorNext(BSTIterator *iter) {
    TreeNode *node = iter->stack[--iter->top];
    pushLeft(node->right, iter);
    return node->val;
}

bool bstIteratorHasNext(BSTIterator *iter) {
    return iter->top > 0;
}

void bstIteratorFree(BSTIterator *iter) {
    free(iter->stack);
    free(iter);
}