#include <stdbool.h>

bool isUnivalTree(struct TreeNode* root) {
    if (root == NULL) {
        return true;
    }

    if (root->left != NULL) {
        if (root->left->val != root->val) {
            return false;
        }
        if (!isUnivalTree(root->left)) {
            return false;
        }
    }

    if (root->right != NULL) {
        if (root->right->val != root->val) {
            return false;
        }
        if (!isUnivalTree(root->right)) {
            return false;
        }
    }

    return true;
}