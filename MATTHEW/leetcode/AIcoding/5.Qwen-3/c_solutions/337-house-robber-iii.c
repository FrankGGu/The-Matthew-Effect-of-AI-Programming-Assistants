#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int max(int a, int b) {
    return a > b ? a : b;
}

int rob(struct TreeNode* root) {
    if (!root) return 0;

    int include = root->val;
    int exclude = 0;

    if (root->left) {
        include += rob(root->left->left) + rob(root->left->right);
        exclude += rob(root->left);
    }

    if (root->right) {
        include += rob(root->right->left) + rob(root->right->right);
        exclude += rob(root->right);
    }

    return max(include, exclude);
}