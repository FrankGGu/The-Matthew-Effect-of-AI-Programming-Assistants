#include <stdlib.h> // Required for malloc

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void addOneRowRecursive(struct TreeNode* node, int val, int currentDepth, int targetDepth) {
    if (node == NULL) {
        return;
    }

    if (currentDepth == targetDepth - 1) {
        // Create new left node
        struct TreeNode* newNodeLeft = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newNodeLeft->val = val;
        newNodeLeft->left = node->left;
        newNodeLeft->right = NULL;

        // Update current node's left child
        node->left = newNodeLeft;

        // Create new right node
        struct TreeNode* newNodeRight = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newNodeRight->val = val;
        newNodeRight->right = node->right;
        newNodeRight->left = NULL;

        // Update current node's right child
        node->right = newNodeRight;

        return; // Stop recursion for this branch, as children are now handled
    }

    // Recurse for children if not at targetDepth - 1
    addOneRowRecursive(node->left, val, currentDepth + 1, targetDepth);
    addOneRowRecursive(node->right, val, currentDepth + 1, targetDepth);
}

struct TreeNode* addOneRow(struct TreeNode* root, int val, int depth) {
    if (depth == 1) {
        struct TreeNode* newRoot = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newRoot->val = val;
        newRoot->left = root;
        newRoot->right = NULL;
        return newRoot;
    }

    addOneRowRecursive(root, val, 1, depth);
    return root;
}