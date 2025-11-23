#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int height(struct TreeNode *root) {
    if (root == NULL) {
        return 0;
    }
    int leftHeight = height(root->left);
    int rightHeight = height(root->right);
    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
}

bool isBalanced(struct TreeNode* root) {
    if (root == NULL) {
        return true;
    }
    int leftHeight = height(root->left);
    int rightHeight = height(root->right);
    int diff = abs(leftHeight - rightHeight);
    if (diff > 1) {
        return false;
    }
    return isBalanced(root->left) && isBalanced(root->right);
}