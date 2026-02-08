#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

int isSymmetricHelper(TreeNode* left, TreeNode* right) {
    if (!left && !right) return 1;
    if (!left || !right) return 0;
    return (left->val == right->val) && isSymmetricHelper(left->left, right->right) && isSymmetricHelper(left->right, right->left);
}

int isSymmetric(struct TreeNode* root) {
    if (!root) return 1;
    return isSymmetricHelper(root->left, root->right);
}