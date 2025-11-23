#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* increasingBST(struct TreeNode* root) {
    struct TreeNode* newRoot = NULL;
    struct TreeNode* prev = NULL;

    void inorder(struct TreeNode* node) {
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