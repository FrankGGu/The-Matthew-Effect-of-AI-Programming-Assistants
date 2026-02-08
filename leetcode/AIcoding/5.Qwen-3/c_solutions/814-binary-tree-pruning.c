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
    if (root->val == 0 && root->left == NULL && root->right == NULL) {
        free(root);
        return NULL;
    }
    return root;
}