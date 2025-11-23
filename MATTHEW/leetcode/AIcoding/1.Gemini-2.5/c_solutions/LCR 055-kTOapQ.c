#include <stdbool.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode** stack;
    int top;
    int capacity;
} BSTIterator;

void push_left_nodes(BSTIterator* obj, struct TreeNode* node) {
    while (node != NULL) {
        if (obj->top < obj->capacity - 1) {
            obj->stack[++(obj->top)] = node;
        }
        node = node->left;
    }
}

BSTIterator* bSTIteratorCreate(struct TreeNode* root) {
    BSTIterator* obj = (BSTIterator*)malloc(sizeof(BSTIterator));
    obj->capacity = 100000;
    obj->stack = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * obj->capacity);
    obj->top = -1;

    push_left_nodes(obj, root);

    return obj;
}

int bSTIteratorNext(BSTIterator* obj) {
    struct TreeNode* current = obj->stack[(obj->top)--];
    int val = current->val;

    if (current->right != NULL) {
        push_left_nodes(obj, current->right);
    }

    return val;
}

bool bSTIteratorHasNext(BSTIterator* obj) {
    return obj->top != -1;
}

void bSTIteratorFree(BSTIterator* obj) {
    free(obj->stack);
    free(obj);
}