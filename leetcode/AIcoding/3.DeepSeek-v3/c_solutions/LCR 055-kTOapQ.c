#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode** stack;
    int top;
} BSTIterator;

BSTIterator* bSTIteratorCreate(struct TreeNode* root) {
    BSTIterator* iterator = (BSTIterator*)malloc(sizeof(BSTIterator));
    iterator->stack = (struct TreeNode**)malloc(100 * sizeof(struct TreeNode*));
    iterator->top = -1;
    struct TreeNode* current = root;
    while (current != NULL) {
        iterator->stack[++(iterator->top)] = current;
        current = current->left;
    }
    return iterator;
}

int bSTIteratorNext(BSTIterator* obj) {
    struct TreeNode* node = obj->stack[(obj->top)--];
    int result = node->val;
    struct TreeNode* current = node->right;
    while (current != NULL) {
        obj->stack[++(obj->top)] = current;
        current = current->left;
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