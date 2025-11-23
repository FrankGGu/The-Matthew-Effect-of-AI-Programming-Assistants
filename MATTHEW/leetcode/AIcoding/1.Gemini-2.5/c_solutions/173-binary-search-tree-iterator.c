#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    struct TreeNode** stack;
    int top; // Index of the top element in the stack
    int capacity; // Maximum capacity of the stack
} BSTIterator;

void _pushAllLeft(BSTIterator* obj, struct TreeNode* node) {
    while (node != NULL) {
        obj->stack[++obj->top] = node;
        node = node->left;
    }
}

BSTIterator* bstIteratorCreate(struct TreeNode* root) {
    BSTIterator* obj = (BSTIterator*)malloc(sizeof(BSTIterator));
    // The problem constraints state up to 10^5 nodes.
    // In the worst case (a skewed tree), the stack might need to hold all nodes.
    obj->capacity = 100000; 
    obj->stack = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * obj->capacity);
    obj->top = -1; // Initialize stack as empty

    // Initialize the stack by pushing all leftmost nodes starting from the root
    _pushAllLeft(obj, root);

    return obj;
}

int bstIteratorNext(BSTIterator* obj) {
    // Pop the top node from the stack
    struct TreeNode* node = obj->stack[obj->top--];
    int val = node->val;

    // If the popped node has a right child, push all its leftmost descendants onto the stack
    _pushAllLeft(obj, node->right);

    return val;
}

bool bstIteratorHasNext(BSTIterator* obj) {
    // The iterator has more elements if the stack is not empty
    return obj->top != -1;
}

void bstIteratorFree(BSTIterator* obj) {
    free(obj->stack);
    free(obj);
}