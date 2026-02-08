#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* increasingBST(TreeNode* root) {
    TreeNode* newRoot = NULL;
    TreeNode* prev = NULL;

    void inorder(TreeNode* node) {
        if (!node) return;
        inorder(node->left);
        if (prev) {
            prev->right = node;
        } else {
            newRoot = node;
        }
        prev = node;
        node->left = NULL;
        inorder(node->right);
    }

    inorder(root);
    return newRoot;
}