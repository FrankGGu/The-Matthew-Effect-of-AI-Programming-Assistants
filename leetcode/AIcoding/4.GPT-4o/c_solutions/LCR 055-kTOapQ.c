#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct BSTIterator {
    struct TreeNode** stack;
    int top;
    struct TreeNode* current;
};

struct BSTIterator* bstIteratorCreate(struct TreeNode* root) {
    struct BSTIterator* iterator = (struct BSTIterator*)malloc(sizeof(struct BSTIterator));
    iterator->stack = (struct TreeNode**)malloc(100 * sizeof(struct TreeNode*));
    iterator->top = -1;
    iterator->current = root;
    return iterator;
}

void bstIteratorPush(struct BSTIterator* iterator) {
    while (iterator->current) {
        iterator->stack[++(iterator->top)] = iterator->current;
        iterator->current = iterator->current->left;
    }
}

int bstIteratorHasNext(struct BSTIterator* iterator) {
    if (iterator->top != -1 || iterator->current) {
        return 1;
    }
    return 0;
}

int bstIteratorNext(struct BSTIterator* iterator) {
    bstIteratorPush(iterator);
    iterator->current = iterator->stack[(iterator->top)--];
    int val = iterator->current->val;
    iterator->current = iterator->current->right;
    return val;
}

void bstIteratorFree(struct BSTIterator* iterator) {
    free(iterator->stack);
    free(iterator);
}