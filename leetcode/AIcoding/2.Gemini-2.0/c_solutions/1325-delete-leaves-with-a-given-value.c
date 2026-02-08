#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode* removeLeafNodes(struct TreeNode* root, int target) {
    if (!root) return NULL;

    root->left = removeLeafNodes(root->left, target);
    root->right = removeLeafNodes(root->right, target);

    if (!root->left && !root->right && root->val == target) {
        free(root);
        return NULL;
    }

    return root;
}