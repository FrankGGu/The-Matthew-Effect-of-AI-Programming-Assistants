#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int max(int a, int b) {
    return (a > b) ? a : b;
}

int rob(struct TreeNode* root) {
    if (!root) return 0;

    int rob_root = root->val;
    if (root->left) {
        rob_root += rob(root->left->left);
        rob_root += rob(root->left->right);
    }
    if (root->right) {
        rob_root += rob(root->right->left);
        rob_root += rob(root->right->right);
    }

    int not_rob_root = rob(root->left) + rob(root->right);

    return max(rob_root, not_rob_root);
}