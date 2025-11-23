#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isUnivalTree(struct TreeNode* root){
    if (!root) return true;

    int val = root->val;

    bool left_unival = true;
    if (root->left) {
        if (root->left->val != val) return false;
        left_unival = isUnivalTree(root->left);
    }

    bool right_unival = true;
    if (root->right) {
        if (root->right->val != val) return false;
        right_unival = isUnivalTree(root->right);
    }

    return left_unival && right_unival;
}