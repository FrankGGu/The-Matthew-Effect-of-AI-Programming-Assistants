#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* pruneTree(struct TreeNode* root) {
    if (root == NULL) return NULL;
    root->left = pruneTree(root->left);
    root->right = pruneTree(root->right);
    if (root->left == NULL && root->right == NULL && root->val == 0) {
        free(root);
        return NULL;
    }
    return root;
}