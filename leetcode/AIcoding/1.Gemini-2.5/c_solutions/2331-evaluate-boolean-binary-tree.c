#include <stdbool.h>

bool evaluateTree(struct TreeNode* root) {
    if (root->val == 0) {
        return false;
    }
    if (root->val == 1) {
        return true;
    }

    if (root->val == 2) { // OR operation
        return evaluateTree(root->left) || evaluateTree(root->right);
    } else { // root->val == 3, AND operation
        return evaluateTree(root->left) && evaluateTree(root->right);
    }
}