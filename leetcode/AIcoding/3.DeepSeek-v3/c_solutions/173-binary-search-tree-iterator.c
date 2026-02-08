#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    TreeNode** stack;
    int top;
} BSTIterator;

BSTIterator* bSTIteratorCreate(struct TreeNode* root) {
    BSTIterator* iterator = (BSTIterator*)malloc(sizeof(BSTIterator));
    iterator->stack = (TreeNode**)malloc(100000 * sizeof(TreeNode*));
    iterator->top = -1;

    TreeNode* current = root;
    while (current != NULL) {
        iterator->stack[++(iterator->top)] = current;
        current = current->left;
    }

    return iterator;
}

int bSTIteratorNext(BSTIterator* obj) {
    TreeNode* node = obj->stack[(obj->top)--];
    int result = node->val;

    node = node->right;
    while (node != NULL) {
        obj->stack[++(obj->top)] = node;
        node = node->left;
    }

    return result;
}

bool bSTIteratorHasNext(BSTIterator* obj) {
    return obj->top >= 0;
}

void bSTIteratorFree(BSTIterator* obj) {
    free(obj->stack);
    free(obj);
}