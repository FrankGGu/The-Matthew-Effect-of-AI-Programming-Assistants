#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct AncestorNode {
    struct TreeNode *node;
    int depth;
    struct AncestorNode *next;
};

struct AncestorNode* push(struct AncestorNode* stack, struct TreeNode* node, int depth) {
    struct AncestorNode* newNode = (struct AncestorNode*)malloc(sizeof(struct AncestorNode));
    newNode->node = node;
    newNode->depth = depth;
    newNode->next = stack;
    return newNode;
}

struct AncestorNode* pop(struct AncestorNode* stack) {
    if (stack == NULL) return NULL;
    struct AncestorNode* temp = stack;
    stack = stack->next;
    free(temp);
    return stack;
}

struct AncestorNode* findKthAncestor(struct TreeNode* node, int k, struct AncestorNode* stack) {
    if (node == NULL) return stack;
    stack = push(stack, node, 0);
    stack = findKthAncestor(node->left, k, stack);
    stack = findKthAncestor(node->right, k, stack);
    return stack;
}

int kthAncestor(struct TreeNode* root, int nodeVal, int k) {
    struct AncestorNode* stack = NULL;
    stack = findKthAncestor(root, k, stack);
    struct AncestorNode* current = stack;
    while (current != NULL && k > 0) {
        current = current->next;
        k--;
    }
    int result = -1;
    if (current != NULL) {
        result = current->node->val;
    }
    while (stack != NULL) {
        stack = pop(stack);
    }
    return result;
}