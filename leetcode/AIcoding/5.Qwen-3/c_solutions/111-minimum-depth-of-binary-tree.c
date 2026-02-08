#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int minDepth(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }
    if (root->left == NULL && root->right == NULL) {
        return 1;
    }
    int left = minDepth(root->left);
    int right = minDepth(root->right);
    if (root->left == NULL || root->right == NULL) {
        return 1 + (left > right ? left : right);
    }
    return 1 + (left < right ? left : right);
}