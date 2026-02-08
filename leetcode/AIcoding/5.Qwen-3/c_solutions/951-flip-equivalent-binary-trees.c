#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* createTreeNode(int val) {
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

bool flipEquiv(struct TreeNode* root1, struct TreeNode* root2) {
    if (!root1 && !root2) return true;
    if (!root1 || !root2) return false;
    if (root1->val != root2->val) return false;

    return (flipEquiv(root1->left, root2->left) && flipEquiv(root1->right, root2->right)) ||
           (flipEquiv(root1->left, root2->right) && flipEquiv(root1->right, root2->left));
}