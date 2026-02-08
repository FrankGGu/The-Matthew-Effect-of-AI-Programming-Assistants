#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int height(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }
    int leftHeight = height(root->left);
    int rightHeight = height(root->right);
    return (leftHeight > rightHeight ? leftHeight : rightHeight) + 1;
}

bool isBalanced(struct TreeNode* root) {
    if (root == NULL) {
        return true;
    }
    int leftHeight = height(root->left);
    int rightHeight = height(root->right);
    int diff = leftHeight - rightHeight;
    if (diff > 1 || diff < -1) {
        return false;
    }
    return isBalanced(root->left) && isBalanced(root->right);
}